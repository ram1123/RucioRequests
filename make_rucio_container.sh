#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<EOF
Usage:
  $0 [dataset_file] [container_name] [rse] [lifetime_seconds]

Defaults:
  dataset_file      = datasets_2022.txt
  container_name    = /Analyses/Hmumurun3_run3Missing/USER
  rse               = T2_US_Purdue
  lifetime_seconds  = 31536000  # 1 year

Examples:
  $0 missing_datasets.txt /Analyses/Hmumurun3_run3MissingV2/USER T2_US_Purdue
  $0 missing_datasets.txt /Analyses/Hmumurun3_run3MissingV2/USER T2_US_Purdue 31536000
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    usage
    exit 0
fi

DATASET_FILE="${1:-datasets_2022.txt}"
CONTAINER_NAME="${2:-/Analyses/Hmumurun3_run3Missing/USER}"
RSE="${3:-T2_US_Purdue}"

# 1 year = 365 * 24 * 3600 = 31536000 seconds
LIFETIME="${4:-31536000}"

echo "-- setting up CMS/Rucio environment --"
source /cvmfs/cms.cern.ch/cmsset_default.sh
source /cvmfs/cms.cern.ch/rucio/setup-py3.sh

echo "-- Rucio version --"
rucio --version || true

echo "-- checking VOMS proxy --"
if ! voms-proxy-info -exists -valid 0:10 >/dev/null 2>&1; then
    echo "[ERROR] No valid VOMS proxy found."
    echo "Run:"
    echo "  voms-proxy-init --voms cms --valid 192:0:0"
    exit 1
fi
echo "== proxy is valid =="

export RUCIO_ACCOUNT="${RUCIO_ACCOUNT:-$(whoami)}"
CONTAINER="user.${RUCIO_ACCOUNT}:${CONTAINER_NAME}"

if [[ ! -f "$DATASET_FILE" ]]; then
    echo "[ERROR] Dataset file not found: $DATASET_FILE"
    exit 1
fi

echo
echo "Dataset file : $DATASET_FILE"
echo "Container    : $CONTAINER"
echo "RSE          : $RSE"
echo "Lifetime     : $LIFETIME seconds"
echo

# Read dataset file:
# - remove empty lines
# - remove comment lines starting with #
# - trim spaces
mapfile -t input_datasets < <(
    sed 's/[[:space:]]*$//' "$DATASET_FILE" \
    | sed 's/^[[:space:]]*//' \
    | grep -v '^#' \
    | grep -v '^$' \
    | sort -u
)

echo "Total unique datasets in file: ${#input_datasets[@]}"

resolved_datasets=()
missing_datasets=()

echo
echo "-- querying DAS --"

for ds in "${input_datasets[@]}"; do
    echo "[DAS] $ds"

    mapfile -t out < <(dasgoclient --query="dataset=${ds}" 2>/dev/null || true)

    if [[ ${#out[@]} -eq 0 ]]; then
        echo "[WARNING] DAS returned nothing for:"
        echo "  $ds"
        missing_datasets+=("$ds")
        continue
    fi

    for x in "${out[@]}"; do
        [[ -n "$x" ]] && resolved_datasets+=("$x")
    done
done

if [[ ${#resolved_datasets[@]} -eq 0 ]]; then
    echo
    echo "[ERROR] No datasets resolved from DAS."
    exit 1
fi

mapfile -t unique_datasets < <(printf "%s\n" "${resolved_datasets[@]}" | sort -u)

echo
echo "Total DAS-resolved datasets        : ${#resolved_datasets[@]}"
echo "Total DAS-resolved unique datasets : ${#unique_datasets[@]}"
echo "Total missing from DAS             : ${#missing_datasets[@]}"

if [[ ${#missing_datasets[@]} -gt 0 ]]; then
    echo
    echo "-- DAS-missing datasets --"
    for ds in "${missing_datasets[@]}"; do
        echo "$ds"
    done
fi

echo
echo "Choose action:"
echo "  list      : only print resolved datasets"
echo "  create    : create Rucio container, attach datasets, and add rule"
echo "  dry-create: print Rucio commands, but do not run them"
echo
read -r -p "Enter your choice [list/create/dry-create]: " choice

case "$choice" in
    list)
        echo
        echo "-- resolved unique datasets --"
        for ds in "${unique_datasets[@]}"; do
            echo "$ds"
        done
        echo
        echo "Total number of datasets: ${#unique_datasets[@]}"
        ;;

    dry-create)
        echo
        echo "-- dry run commands --"
        echo "rucio did add --type container \"$CONTAINER\""

        for ds in "${unique_datasets[@]}"; do
            echo "rucio did content add \"$CONTAINER\" \"cms:$ds\""
        done

        echo "rucio rule add --lifetime \"$LIFETIME\" --ask-approval \"$CONTAINER\" 1 \"$RSE\""
        ;;

    create)
        echo
        echo "-- creating/using Rucio container --"
        echo "$CONTAINER"

        # New command replacing deprecated:
        #   rucio add-container
        rucio did add --type container "$CONTAINER" || true

        echo
        echo "-- attaching datasets --"
        for ds in "${unique_datasets[@]}"; do
            echo "[ATTACH] cms:$ds"

            # New command replacing deprecated:
            #   rucio attach
            rucio did content add "$CONTAINER" "cms:$ds" || true
        done

        echo
        echo "Total number of unique datasets attached/requested: ${#unique_datasets[@]}"

        echo
        echo "-- adding Rucio rule --"

        # New command replacing deprecated:
        #   rucio add-rule
        RULE_ID=$(
            rucio rule add \
                --lifetime "$LIFETIME" \
                --ask-approval \
                "$CONTAINER" \
                1 \
                "$RSE"
        )

        echo
        echo "Rule ID: $RULE_ID"
        echo "Done."
        ;;

    *)
        echo "[ERROR] Invalid input. Please type 'list', 'create', or 'dry-create'."
        exit 1
        ;;
esac
