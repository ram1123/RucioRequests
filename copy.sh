source /cvmfs/cms.cern.ch/rucio/setup-py3.sh

# STEP-1: create a user container
#OLD COMMAND
rucio add-container user.rasharma:/Analyses/Hmumu2020v1/USER
#NEW COMMAND
# rucio did add --type container --did user.rasharma:/Analyses/Hmumu2020v1/USER

# STEP-2: add some initial datasets to the container
# OLD COMMAND
rucio attach user.rasharma:/Analyses/Hmumu2020v1/USER cms:/SingleMuon/Run2018B-UL2018_MiniAODv2_GT36-v1/MINIAOD
#NEW COMMAND
# rucio did content add --to user.rasharma:/Analyses/Hmumu2020v1/USER --did cms:/SingleMuon/Run2018B-UL2018_MiniAODv2_GT36-v1/MINIAOD

# STEP-3: add Block1 to the dataset
rucio add-dataset user.rasharma:/Analyses/Hmumu2020v1/USER#block1

# STEP-4: add files to the Block1
rucio attach user.rasharma:/Analyses/Hmumu2020v1/USER#block1 cms:/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/9F61F9B2-3895-9D46-9930-AE0FF808FD5A.root

rucio attach user.rasharma:/Analyses/Hmumu2020v1/USER#block1 cms:/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/C9687E82-B67B-B743-9215-5B619DF3B8EA.root
rucio attach user.rasharma:/Analyses/Hmumu2020v1/USER#block1 cms:/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/368F2C0F-2B95-D640-BFFE-AC0C622A7FA4.root
rucio attach user.rasharma:/Analyses/Hmumu2020v1/USER#block1 cms:/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/A4B9B370-55C3-5A43-A093-93114BCF790E.root
rucio attach user.rasharma:/Analyses/Hmumu2020v1/USER#block1 cms:/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/B8F0349B-555E-4944-BF02-DED2CF28705E.root
rucio attach user.rasharma:/Analyses/Hmumu2020v1/USER#block1 cms:/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/9B7803AE-0FBB-724F-9F38-AFBAE0B6E0F4.root
rucio attach user.rasharma:/Analyses/Hmumu2020v1/USER#block1 cms:/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/06FBF456-3522-B44F-BE50-1E806A8044B9.root
rucio attach user.rasharma:/Analyses/Hmumu2020v1/USER#block1 cms:/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/C3625AD3-1AB3-B048-9059-0807E6F51812.root

rucio list-content user.rasharma:/Analyses/Hmumu2020v1/USER
rucio list-content user.rasharma:/Analyses/Hmumu2020v1/USER#block1

rucio detach user.rasharma:/Analyses/Hmumu2020v1/USER cms:/SingleMuon/Run2018B-UL2018_MiniAODv2_GT36-v1/MINIAOD
rucio close user.rasharma:/Analyses/Hmumu2020v1/USER#block1

rucio add-rule --lifetime 7776000 --ask-approval  user.rasharma:/Analyses/Hmumu2020v1/USER 1 T2_US_Purdue
