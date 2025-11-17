# RucioRequests

| old command | new command |
| ----------- | ----------- |
| rucio list-dids user.rasharma:* | rucio did list  -d user.rasharma:* |
|rucio add-container user.rasharma:/Analyses/HmumuUL2018Mis/USER | rucio did add --type container -d user.rasharma:/Analyses/HmumuUL2018Mis/USER |
|rucio attach user.rasharma:/Analyses/HmumuUL2018Mis/USER cms:$i | rucio did content add --type container -d user.rasharma:/Analyses/HmumuUL2018Mis/USER cms:$i |


# Message from Stefan

```
The 'old' style commands still work OK for me on LXPLUS8.
Where did you do your testing?

2) A file cannot be attached to a dataset directly - that's true, and it is not documented because it has never been used in CMS so far. You need to introduce the intermediate structure ('Block' in CMS terms, or 'Dataset DID' in Rucio terms). Then you add the file(s) to the block.

Here's what I just did on lxplus8.cern.ch:

"============================================================================"
┌[piperov@lxplus800]{}[~]
└$ rucio add-container user.piperov:/Tests/April2025/USER
Added user.piperov:/Tests/April2025/USER

┌[piperov@lxplus800]{}[~]
└$ rucio attach user.piperov:/Tests/April2025/USER cms:/SingleMuon/Run2018B-02Apr2020-v1/NANOAOD
DIDs successfully attached to user.piperov:/Tests/April2025/USER

(this up to here was arepetition of the process already documented in the Twiki)

┌[piperov@lxplus800]{}[~]
└$ rucio add-dataset user.piperov:/Tests/April2025/USER#block1
Added user.piperov:/Tests/April2025/USER#block1

┌[piperov@lxplus800]{}[~]
└$ rucio attach user.piperov:/Tests/April2025/USER#block1 cms:/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/9F61F9B2-3895-9D46-9930-AE0FF808FD5A.root
DIDs successfully attached to user.piperov:/Tests/April2025/USER#block1

(this was the new part)

Finally, check the contents:

┌[piperov@lxplus800]{}[~]
└$ rucio list-content user.piperov:/Tests/April2025/USER
+-----------------------------------------------+--------------+
| SCOPE:NAME | [DID TYPE] |
|-----------------------------------------------+--------------|
| cms:/SingleMuon/Run2018B-02Apr2020-v1/NANOAOD | CONTAINER |
+-----------------------------------------------+--------------+

┌[piperov@lxplus800]{}[~]
└$ rucio list-content user.piperov:/Tests/April2025/USER#block1
+------------------------------------------------------------------------------------------------------------------------+--------------+
| SCOPE:NAME | [DID TYPE] |
|------------------------------------------------------------------------------------------------------------------------+--------------|
| cms:/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/9F61F9B2-3895-9D46-9930-AE0FF808FD5A.root | FILE |
+------------------------------------------------------------------------------------------------------------------------+--------------+
"============================================================================"
```


# File size

/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/9F61F9B2-3895-9D46-9930-AE0FF808FD5A.root,3007324537
/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/C9687E82-B67B-B743-9215-5B619DF3B8EA.root,4138892759
/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/368F2C0F-2B95-D640-BFFE-AC0C622A7FA4.root,3030336003
/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/A4B9B370-55C3-5A43-A093-93114BCF790E.root,3721924924
/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/B8F0349B-555E-4944-BF02-DED2CF28705E.root,2934861267
/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/9B7803AE-0FBB-724F-9F38-AFBAE0B6E0F4.root,3204182773
/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/06FBF456-3522-B44F-BE50-1E806A8044B9.root,2942614193
/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/C3625AD3-1AB3-B048-9059-0807E6F51812.root,3973263530
