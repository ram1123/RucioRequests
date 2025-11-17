Referece: https://cern.service-now.com/service-portal?id=kb_article&n=KB0007167


```bash
[rasharma@lxplus922 RucioRequests]$ fts-rest-transfer-submit -s https://fts3-public.cern.ch:8446 \
> root://eosctapublic.cern.ch/eos/ctapublic/archive/cms/store/data/Run2018B/SingleMuon/MINIAOD/UL2018_MiniAODv2_GT36-v1/2520000/9F61F9B2-3895-9D46-9930-AE0FF808FD5A.root \
> root://eospublic.cern.ch/eos/user/r/rasharma/9F61F9B2-3895-9D46-9930-AE0FF808FD5A.root  --bring-online 259200
Job successfully submitted.
Job id: 8f88ca34-1b9f-11f0-989b-fa163e1c1d93
[rasharma@lxplus922 RucioRequests]$ fts-rest-transfer-status -s https://fts3-public.cern.ch:8446 \
> 8f88ca34-1b9f-11f0-989b-fa163e1c1d93
Request ID: 8f88ca34-1b9f-11f0-989b-fa163e1c1d93
Status: STAGING
Client DN: /DC=ch/DC=cern/OU=Organic Units/OU=Users/CN=rasharma/CN=749075/CN=Ram Krishna Sharma
Reason: None
Submission time: 2025-04-17T15:20:57
Priority: 3
VO Name: cms

[rasharma@lxplus922 RucioRequests]$ fts-rest-transfer-status -s https://fts3-public.cern.ch:8446 8f88ca34-1b9f-11f0-989b-fa163e1c1d93
Request ID: 8f88ca34-1b9f-11f0-989b-fa163e1c1d93
Status: STAGING
Client DN: /DC=ch/DC=cern/OU=Organic Units/OU=Users/CN=rasharma/CN=749075/CN=Ram Krishna Sharma
Reason: None
Submission time: 2025-04-17T15:20:57
Priority: 3
VO Name: cms
```
