#!/bin/bash

echo "--setting up the rucio environment--"
source /cvmfs/cms.cern.ch/cmsset_default.sh
source /cvmfs/cms.cern.ch/rucio/setup-py3.sh

echo "--setting up the voms proxy--"
# voms-proxy-init --voms cms --valid 192:0:0

echo "==proxy is valid=="

export RUCIO_ACCOUNT=$(whoami)

data=()
if [ -f "listoffiles.txt" ]; then
    while IFS= read -r line; do
        data+=("$line")
    done < "listoffiles.txt"
else
    echo "File listoffiles.txt not found. Exiting."
    exit 1
fi

echo "==printing files=="
for f in "${data[@]}"; do echo "$f"; done
echo "Total number of files: ${#data[@]}"

echo "Type 'list' to list files or 'create' to register in Rucio and request to Purdue:"
read my_var

SCOPE="user.${RUCIO_ACCOUNT}"
CONTAINER_NAME="${SCOPE}:Analyses.HmumuUL2018Mis.USER"
DATASET_NAME="${SCOPE}:Analyses.HmumuUL2018Mis.DATASET"

if [ "$my_var" = "list" ]; then
    for f in "${data[@]}"; do echo "$f"; done

elif [ "$my_var" = "create" ]; then
    echo "You chose to create a container and dataset."

    # Create container if missing
    if ! rucio did list --did "${CONTAINER_NAME}" &> /dev/null; then
        rucio did add --type container --did "${CONTAINER_NAME}"
    else
        echo "Container already exists."
    fi

    # Create dataset if missing
    if ! rucio did list --did "${DATASET_NAME}" &> /dev/null; then
        rucio did add --type dataset --did "${DATASET_NAME}"
    else
        echo "Dataset already exists."
    fi

    # Attach files to dataset
    for f in "${data[@]}"; do
        echo "Adding file cms:$f to dataset ${DATASET_NAME}"
        # rucio did content add --did "cms:$f" --to "${DATASET_NAME}"
        rucio did content add --did "cms:$f" --to "${DATASET_NAME}"
    done

    # Attach dataset to container
    echo "Attaching dataset to container"
    # rucio did content add --did "${DATASET_NAME}" --to "${CONTAINER_NAME}"
    rucio did content add --did "${DATASET_NAME}" --to "${CONTAINER_NAME}"

    # Create rule
    echo "Requesting rule to copy container to T2_US_Purdue"
    # rucio rule add --copies 1 --did "${CONTAINER_NAME}" --rse-expression "T2_US_Purdue" --ask-approval --lifetime 7776000
    rucio rule add --copies 1 "${CONTAINER_NAME}" "T2_US_Purdue" --ask-approval --lifetime 7776000


else
    echo "Invalid input. Please type 'list' or 'create'."
fi
