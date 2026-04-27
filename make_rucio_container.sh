#!/usr/bin/env bash
set -euo pipefail

echo "Usage: $0 [dataset_file] [container_name] [rse] [lifetime_seconds]"

DATASET_FILE="${1:-datasets_2022.txt}"

CONTAINER_NAME="${2:-/Analyses/Hmumurun3_run3Missing/USER}"
RSE="${3:-T2_US_Purdue}"
LIFETIME="${4:-31536000}"   # 90 days = 90*24*3600 = 7776000 seconds
                                                # 1 year = 1*365*24*3600 = 31536000 seconds

echo "-- setting up CMS/Rucio environment --"
source /cvmfs/cms.cern.ch/cmsset_default.sh
source /cvmfs/cms.cern.ch/rucio/setup-py3.sh

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
echo "Lifetime     : $LIFETIME"
echo

# Read dataset file:
# - remove empty lines
# - remove comment lines starting with #
# - trim spaces
mapfile -t input_datasets < <(
    sed 's/[[:space:]]*$//' "$DATASET_FILE" \
    | sed 's/^[[:space:]]*//' \
    | grep -v '^#' \
    | grep -v '^$'
)

echo "Total datasets in file: ${#input_datasets[@]}"

resolved_datasets=()

echo
echo "-- querying DAS --"

for ds in "${input_datasets[@]}"; do
    echo "[DAS] $ds"

    mapfile -t out < <(dasgoclient --query="dataset=${ds}" 2>/dev/null || true)

    if [[ ${#out[@]} -eq 0 ]]; then
        echo "[WARNING] DAS returned nothing for:"
        echo "  $ds"
        continue
    fi

    for x in "${out[@]}"; do
        [[ -n "$x" ]] && resolved_datasets+=("$x")
    done
done

if [[ ${#resolved_datasets[@]} -eq 0 ]]; then
    echo "[ERROR] No datasets resolved from DAS."
    exit 1
fi

mapfile -t unique_datasets < <(printf "%s\n" "${resolved_datasets[@]}" | sort -u)

echo
echo "Total DAS-resolved datasets        : ${#resolved_datasets[@]}"
echo "Total DAS-resolved unique datasets : ${#unique_datasets[@]}"
echo

echo "Choose action:"
echo "  list   : only print datasets"
echo "  create : create Rucio container, attach datasets, and add rule"
echo
read -r -p "Enter your choice [list/create]: " choice

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

    create)
        echo
        echo "-- creating/using Rucio container --"
        echo "$CONTAINER"

        rucio add-container "$CONTAINER" || true

        echo
        echo "-- attaching datasets --"
        for ds in "${unique_datasets[@]}"; do
            echo "[ATTACH] cms:$ds"
            rucio attach "$CONTAINER" "cms:$ds" || true
        done

        echo
        echo "Total number of unique datasets attached/requested: ${#unique_datasets[@]}"

        echo
        echo "-- adding Rucio rule --"
        rucio add-rule \
            --lifetime "$LIFETIME" \
            --ask-approval \
            "$CONTAINER" \
            1 \
            "$RSE"

        echo
        echo "Done."
        ;;

    *)
        echo "[ERROR] Invalid input. Please type 'list' or 'create'."
        exit 1
        ;;
esac
