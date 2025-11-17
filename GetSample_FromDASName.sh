echo "--setting up the rucio environment--"
source /cvmfs/cms.cern.ch/cmsset_default.sh
source /cvmfs/cms.cern.ch/rucio/setup-py3.sh

echo "--setting up the voms proxy--"
# voms-proxy-init --voms cms --valid 192:0:0

echo "==proxy is valid=="

export RUCIO_ACCOUNT=`whoami`

dy1=( $(dasgoclient --query="dataset = /GluGluToBulkGravitonToHHTo2G2WTo2G2Q1L1Nu_M-700_TuneCP5_PSWeights_narrow_13TeV-madgraph-pythia8/RunIISummer20UL18MiniAODv2-106X_upgrade2018_realistic_v16_L1v1-v2/MINIAODSIM"))

# 2016
# dy3=( $(dasgoclient --query="dataset = /DYJetsToLL_M-105To160_VBFFilter_TuneCUETP8M1_13TeV-amcatnloFXFX-pythia8/RunIISummer16NanoAODv6-PUMoriond17_Nano25Oct2019_VBFPostMGFilter_102X_mcRun2_asymptotic_v7_ext1-v1/NANOAODSIM"))
# dy4=( $(dasgoclient --query="dataset = /DYJetsToLL_M-105To160_VBFFilter_TuneCUETP8M1_13TeV-amcatnloFXFX-pythia8/RunIISummer16NanoAODv6-PUMoriond17_Nano25Oct2019_VBFPostMGFilter_102X_mcRun2_asymptotic_v7_ext2-v1/NANOAODSIM"))


# dy1+=(${dy2[@]})
# dy1+=(${dy3[@]})
# dy1+=(${dy4[@]})



echo "if you are only listing datasets, type list OR if you are creating container, print create"

read my_var

if [ "$my_var" = "list" ]; then
    echo "You chose to list datasets."
elif [ "$my_var" = "create" ]; then
    echo "You chose to create a container."
else
    echo "Invalid input. Please type 'list' or 'create'."
fi


if [ "$my_var" = "list" ]; then
    for i in "${dy1[@]}"
    do
       echo "$i"
    done
    echo "Total number of datasets : ${#dy1[@]}"
elif [ "$my_var" = "create" ]; then
	echo "adding rucio container"

	rucio add-container user.rasharma:/Analyses/HHGraviton/USER
	for i in "${dy1[@]}"
	do
		rucio attach user.rasharma:/Analyses/HHGraviton/USER cms:$i
	done
	echo "Total number of datasets : ${#dy1[@]}"
else
	echo "Invalid input. Please check username"
fi


rucio add-rule --lifetime 7776000 --ask-approval  user.rasharma:/Analyses/HHGraviton/USER 1 T2_US_Purdue


