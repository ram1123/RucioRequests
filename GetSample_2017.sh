echo "--setting up the rucio environment--"
source /cvmfs/cms.cern.ch/cmsset_default.sh
source /cvmfs/cms.cern.ch/rucio/setup-py3.sh

echo "--setting up the voms proxy--"
# voms-proxy-init --voms cms --valid 192:0:0

echo "==proxy is valid=="

export RUCIO_ACCOUNT=`whoami`

dy1=( $(dasgoclient --query="dataset = /SingleMuon/Run2017B-UL2017_NanoAODv15-v1/NANOAOD"))
dy2=( $(dasgoclient --query="dataset = /SingleMuon/Run2017C-UL2017_NanoAODv15-v1/NANOAOD"))
dy1+=(${dy2[@]})
dy3=( $(dasgoclient --query="dataset = /SingleMuon/Run2017D-UL2017_NanoAODv15-v1/NANOAOD"))
dy1+=(${dy3[@]})
dy4=( $(dasgoclient --query="dataset = /SingleMuon/Run2017E-UL2017_NanoAODv15-v1/NANOAOD"))
dy1+=(${dy4[@]})
dy5=( $(dasgoclient --query="dataset = /SingleMuon/Run2017F-UL2017_NanoAODv15-v1/NANOAOD"))
dy1+=(${dy5[@]})
dy6=( $(dasgoclient --query="dataset = /SingleMuon/Run2017G-UL2017_NanoAODv15-v1/NANOAOD"))
dy1+=(${dy6[@]})
dy7=( $(dasgoclient --query="dataset = /SingleMuon/Run2017H-UL2017_NanoAODv15-v1/NANOAOD"))
dy1+=(${dy7[@]})
dy8=( $(dasgoclient --query="dataset = /DYJetsToMuMu_M-10to50_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy8[@]})
dy9=( $(dasgoclient --query="dataset = /DYJetsToMuMu_M-10to50_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1_ext1-v1/NANOAODSIM"))
dy1+=(${dy9[@]})
dy10=( $(dasgoclient --query="dataset = /DYJetsToMuMu_M-100to200_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy10[@]})
dy11=( $(dasgoclient --query="dataset = /DYJetsToMuMu_M-200to400_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy11[@]})
dy12=( $(dasgoclient --query="dataset = /DYJetsToLL_M-10to50_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy12[@]})
dy13=( $(dasgoclient --query="dataset = /DYJetsToLL_M-50_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy13[@]})
dy14=( $(dasgoclient --query="dataset = /DYJetsToLL_M-50_TuneCP5_13TeV-madgraphMLM-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v2/NANOAODSIM"))
dy1+=(${dy14[@]})
dy15=( $(dasgoclient --query="dataset = /DYJetsToLL_M-50_TuneCP5_13TeV-madgraphMLM-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1_ext1-v1/NANOAODSIM"))
dy1+=(${dy15[@]})
dy16=( $(dasgoclient --query="dataset = /DYJetsToLL_LHEFilterPtZ-0To50_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy16[@]})
dy17=( $(dasgoclient --query="dataset = /DYJetsToLL_LHEFilterPtZ-50To100_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy17[@]})
dy18=( $(dasgoclient --query="dataset = /DYJetsToLL_LHEFilterPtZ-100To250_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy18[@]})
dy19=( $(dasgoclient --query="dataset = /DYJetsToLL_LHEFilterPtZ-250To400_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy19[@]})
dy20=( $(dasgoclient --query="dataset = /DYJetsToLL_LHEFilterPtZ-400To650_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy20[@]})
dy21=( $(dasgoclient --query="dataset = /DYJetsToLL_LHEFilterPtZ-650ToInf_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy21[@]})
dy22=( $(dasgoclient --query="dataset = /TTJets_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy22[@]})
dy23=( $(dasgoclient --query="dataset = /TTTo2L2Nu_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v2/NANOAODSIM"))
dy1+=(${dy23[@]})
dy24=( $(dasgoclient --query="dataset = /TTToSemiLeptonic_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v2/NANOAODSIM"))
dy1+=(${dy24[@]})
dy25=( $(dasgoclient --query="dataset = /TTToHadronic_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v2/NANOAODSIM"))
dy1+=(${dy25[@]})
dy26=( $(dasgoclient --query="dataset = /ST_tW_top_5f_inclusiveDecays_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy26[@]})
dy27=( $(dasgoclient --query="dataset = /ST_tW_antitop_5f_inclusiveDecays_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy27[@]})
dy28=( $(dasgoclient --query="dataset = /ST_t-channel_top_4f_InclusiveDecays_TuneCP5_13TeV-powheg-madspin-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy28[@]})
dy29=( $(dasgoclient --query="dataset = /ST_t-channel_antitop_4f_InclusiveDecays_TuneCP5_13TeV-powheg-madspin-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy29[@]})
dy30=( $(dasgoclient --query="dataset = /ST_s-channel_4f_hadronicDecays_TuneCP5_13TeV-amcatnlo-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy30[@]})
dy31=( $(dasgoclient --query="dataset = /ST_s-channel_4f_leptonDecays_TuneCP5_13TeV-amcatnlo-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy31[@]})
dy32=( $(dasgoclient --query="dataset = /WWTo1L1Nu2Q_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy32[@]})
dy33=( $(dasgoclient --query="dataset = /WWTo2L2Nu_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy33[@]})
dy34=( $(dasgoclient --query="dataset = /WWTo4Q_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy34[@]})
dy35=( $(dasgoclient --query="dataset = /WZTo1L1Nu2Q_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy35[@]})
dy36=( $(dasgoclient --query="dataset = /WZTo1L3Nu_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy36[@]})
dy37=( $(dasgoclient --query="dataset = /WZTo3LNu_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy37[@]})
dy38=( $(dasgoclient --query="dataset = /WZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy38[@]})
dy39=( $(dasgoclient --query="dataset = /WZTo2Q2Nu_4f_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy39[@]})
dy40=( $(dasgoclient --query="dataset = /ZZTo2L2Nu_TuneCP5_13TeV_powheg_pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy40[@]})
dy41=( $(dasgoclient --query="dataset = /ZZTo2Nu2Q_5f_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy41[@]})
dy42=( $(dasgoclient --query="dataset = /ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy42[@]})
dy43=( $(dasgoclient --query="dataset = /ZZTo4L_TuneCP5_13TeV_powheg_pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy43[@]})
dy44=( $(dasgoclient --query="dataset = /ZZTo4Q_5f_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy44[@]})
dy45=( $(dasgoclient --query="dataset = /WWW_4F_TuneCP5_13TeV-amcatnlo-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy45[@]})
dy46=( $(dasgoclient --query="dataset = /WWW_4F_TuneCP5_13TeV-amcatnlo-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1_ext1-v1/NANOAODSIM"))
dy1+=(${dy46[@]})
dy47=( $(dasgoclient --query="dataset = /WWZ_4F_TuneCP5_13TeV-amcatnlo-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy47[@]})
dy48=( $(dasgoclient --query="dataset = /WWZ_4F_TuneCP5_13TeV-amcatnlo-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1_ext1-v1/NANOAODSIM"))
dy1+=(${dy48[@]})
dy49=( $(dasgoclient --query="dataset = /WZZ_TuneCP5_13TeV-amcatnlo-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy49[@]})
dy50=( $(dasgoclient --query="dataset = /WZZ_TuneCP5_13TeV-amcatnlo-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1_ext1-v1/NANOAODSIM"))
dy1+=(${dy50[@]})
dy51=( $(dasgoclient --query="dataset = /ZZZ_TuneCP5_13TeV-amcatnlo-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy51[@]})
dy52=( $(dasgoclient --query="dataset = /ZZZ_TuneCP5_13TeV-amcatnlo-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1_ext1-v1/NANOAODSIM"))
dy1+=(${dy52[@]})
dy53=( $(dasgoclient --query="dataset = /EWKZ2Jets_ZToLL_M-50_TuneCP5_withDipoleRecoil_13TeV-madgraph-pythia8/RunIISummer20UL17NanoAODv15-150X_mc2017_realistic_v1-v1/NANOAODSIM"))
dy1+=(${dy53[@]})



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
