echo "--setting up the rucio environment--"
source /cvmfs/cms.cern.ch/cmsset_default.sh
source /cvmfs/cms.cern.ch/rucio/setup-py3.sh

echo "--setting up the voms proxy--"
# voms-proxy-init --voms cms --valid 192:0:0

echo "==proxy is valid=="

export RUCIO_ACCOUNT=`whoami`

dy1=( $(dasgoclient --query="dataset = /Muon0/Run2023C-22Sep2023_v1-v1/NANOAOD"))
dy2=( $(dasgoclient --query="dataset = /Muon0/Run2023C-22Sep2023_v2-v1/NANOAOD"))
dy1+=(${dy2[@]})
dy3=( $(dasgoclient --query="dataset = /Muon0/Run2023C-22Sep2023_v3-v1/NANOAOD"))
dy1+=(${dy3[@]})
dy4=( $(dasgoclient --query="dataset = /Muon0/Run2023C-22Sep2023_v4-v1/NANOAOD"))
dy1+=(${dy4[@]})
dy5=( $(dasgoclient --query="dataset = /Muon1/Run2023C-22Sep2023_v1-v1/NANOAOD"))
dy1+=(${dy5[@]})
dy6=( $(dasgoclient --query="dataset = /Muon1/Run2023C-22Sep2023_v2-v1/NANOAOD"))
dy1+=(${dy6[@]})
dy7=( $(dasgoclient --query="dataset = /Muon1/Run2023C-22Sep2023_v3-v1/NANOAOD"))
dy1+=(${dy7[@]})
dy8=( $(dasgoclient --query="dataset = /Muon1/Run2023C-22Sep2023_v4-v2/NANOAOD"))
dy1+=(${dy8[@]})
dy9=( $(dasgoclient --query="dataset = /DYto2L-2Jets_MLL-50_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v3/NANOAODSIM"))
dy1+=(${dy9[@]})
dy10=( $(dasgoclient --query="dataset = /DYto2L-2Jets_MLL-50_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v3/NANOAODSIM"))
dy1+=(${dy10[@]})
dy11=( $(dasgoclient --query="dataset = /DYto2L-2Jets_MLL-50_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v4/NANOAODSIM"))
dy1+=(${dy11[@]})
dy12=( $(dasgoclient --query="dataset = /DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v2/NANOAODSIM"))
dy1+=(${dy12[@]})
dy13=( $(dasgoclient --query="dataset = /DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v2/NANOAODSIM"))
dy1+=(${dy13[@]})
dy14=( $(dasgoclient --query="dataset = /TTtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v2/NANOAODSIM"))
dy1+=(${dy14[@]})
dy15=( $(dasgoclient --query="dataset = /TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v2/NANOAODSIM"))
dy1+=(${dy15[@]})
dy16=( $(dasgoclient --query="dataset = /TTto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v2/NANOAODSIM"))
dy1+=(${dy16[@]})
dy17=( $(dasgoclient --query="dataset = /WWto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v4/NANOAODSIM"))
dy1+=(${dy17[@]})
dy18=( $(dasgoclient --query="dataset = /WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v2/NANOAODSIM"))
dy1+=(${dy18[@]})
dy19=( $(dasgoclient --query="dataset = /WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v15_ext1-v2/NANOAODSIM"))
dy1+=(${dy19[@]})
dy20=( $(dasgoclient --query="dataset = /WZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v3/NANOAODSIM"))
dy1+=(${dy20[@]})
dy21=( $(dasgoclient --query="dataset = /WZtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v2/NANOAODSIM"))
dy1+=(${dy21[@]})
dy22=( $(dasgoclient --query="dataset = /ZZ_TuneCP5_13p6TeV_pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v2/NANOAODSIM"))
dy1+=(${dy22[@]})
dy23=( $(dasgoclient --query="dataset = /ZZto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v3/NANOAODSIM"))
dy1+=(${dy23[@]})
dy24=( $(dasgoclient --query="dataset = /ZZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v3/NANOAODSIM"))
dy1+=(${dy24[@]})
dy25=( $(dasgoclient --query="dataset = /ZZto4L_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v14-v3/NANOAODSIM"))
dy1+=(${dy25[@]})
dy26=( $(dasgoclient --query="dataset = /EWK_2L2J_TuneCH3_13p6TeV_madgraph-herwig7/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v15-v2/NANOAODSIM"))
dy1+=(${dy26[@]})
dy27=( $(dasgoclient --query="dataset = /GluGluHto2Mu_M-125_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v15-v2/NANOAODSIM"))
dy1+=(${dy27[@]})
dy28=( $(dasgoclient --query="dataset = /VBFHto2Mu_M-125_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v15-v2/NANOAODSIM"))
dy1+=(${dy28[@]})
dy29=( $(dasgoclient --query="dataset = /VBFH_Hto2Mu_M-125_TuneCP5_13p6TeV_amcatnlo-pythia8/Run3Summer23NanoAODv12-130X_mcRun3_2023_realistic_v15-v2/NANOAODSIM"))
dy1+=(${dy29[@]})
dy30=( $(dasgoclient --query="dataset = /Muon0/Run2023D-22Sep2023_v1-v1/NANOAOD"))
dy1+=(${dy30[@]})
dy31=( $(dasgoclient --query="dataset = /Muon0/Run2023D-22Sep2023_v2-v1/NANOAOD"))
dy1+=(${dy31[@]})
dy32=( $(dasgoclient --query="dataset = /Muon1/Run2023D-22Sep2023_v1-v1/NANOAOD"))
dy1+=(${dy32[@]})
dy33=( $(dasgoclient --query="dataset = /Muon1/Run2023D-22Sep2023_v2-v1/NANOAOD"))
dy1+=(${dy33[@]})
dy34=( $(dasgoclient --query="dataset = /DYto2L-2Jets_MLL-50_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v3/NANOAODSIM"))
dy1+=(${dy34[@]})
dy35=( $(dasgoclient --query="dataset = /DYto2L-2Jets_MLL-50_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v3/NANOAODSIM"))
dy1+=(${dy35[@]})
dy36=( $(dasgoclient --query="dataset = /DYto2L-2Jets_MLL-50_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v3/NANOAODSIM"))
dy1+=(${dy36[@]})
dy37=( $(dasgoclient --query="dataset = /DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v4/NANOAODSIM"))
dy1+=(${dy37[@]})
dy38=( $(dasgoclient --query="dataset = /TTtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v3/NANOAODSIM"))
dy1+=(${dy38[@]})
dy39=( $(dasgoclient --query="dataset = /TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v3/NANOAODSIM"))
dy1+=(${dy39[@]})
dy40=( $(dasgoclient --query="dataset = /TTto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v3/NANOAODSIM"))
dy1+=(${dy40[@]})
dy41=( $(dasgoclient --query="dataset = /WWto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v3/NANOAODSIM"))
dy1+=(${dy41[@]})
dy42=( $(dasgoclient --query="dataset = /WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v2/NANOAODSIM"))
dy1+=(${dy42[@]})
dy43=( $(dasgoclient --query="dataset = /WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v6_ext1-v2/NANOAODSIM"))
dy1+=(${dy43[@]})
dy44=( $(dasgoclient --query="dataset = /WZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v2/NANOAODSIM"))
dy1+=(${dy44[@]})
dy45=( $(dasgoclient --query="dataset = /WZtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v2/NANOAODSIM"))
dy1+=(${dy45[@]})
dy46=( $(dasgoclient --query="dataset = /ZZ_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v2/NANOAODSIM"))
dy1+=(${dy46[@]})
dy47=( $(dasgoclient --query="dataset = /ZZto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v3/NANOAODSIM"))
dy1+=(${dy47[@]})
dy48=( $(dasgoclient --query="dataset = /ZZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v3/NANOAODSIM"))
dy1+=(${dy48[@]})
dy49=( $(dasgoclient --query="dataset = /ZZto4L_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v2-v3/NANOAODSIM"))
dy1+=(${dy49[@]})
dy50=( $(dasgoclient --query="dataset = /EWK_2L2J_TuneCH3_13p6TeV_madgraph-herwig7/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v6-v2/NANOAODSIM"))
dy1+=(${dy50[@]})
dy51=( $(dasgoclient --query="dataset = /GluGluHto2Mu_M-125_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v6-v2/NANOAODSIM"))
dy1+=(${dy51[@]})
dy52=( $(dasgoclient --query="dataset = /GluGluHto2Mu_M-125_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v6-v2/NANOAODSIM"))
dy1+=(${dy52[@]})
dy53=( $(dasgoclient --query="dataset = /VBFHto2Mu_M-125_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v6-v2/NANOAODSIM"))
dy1+=(${dy53[@]})
dy54=( $(dasgoclient --query="dataset = /VBFH_Hto2Mu_M-125_TuneCP5_13p6TeV_amcatnlo-pythia8/Run3Summer23BPixNanoAODv12-130X_mcRun3_2023_realistic_postBPix_v6-v2/NANOAODSIM"))
dy1+=(${dy54[@]})



echo "if you are only listing datasets, type list OR if you are creating container, print create"

echo "Enter your choice (list/create): "
read my_var

echo "You entered: $my_var"
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

fi

if [ "$my_var" = "create" ]; then
    echo "adding rucio container"

    rucio add-container user.rasharma:/Analyses/Hmumurun3_2023v1/USER
    for i in "${dy1[@]}"; do
        rucio attach user.rasharma:/Analyses/Hmumurun3_2023v1/USER cms:$i
    done
    echo "Total number of datasets : ${#dy1[@]}"

    echo "adding rule"
    rucio add-rule --lifetime 7776000 --ask-approval user.rasharma:/Analyses/Hmumurun3_2023v1/USER 1 T2_US_Purdue
fi
