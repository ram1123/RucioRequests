# RucioRequests

Personal scripts for requesting CMS datasets via Rucio for the Hmumu (H→μμ) analysis:
resolve dataset names through DAS, bundle them into a Rucio container, and add a
replication rule to copy that container to a site (RSE).

## Steps

1. Set up the CMS/Rucio environment and a VOMS proxy:

```bash
source /cvmfs/cms.cern.ch/cmsset_default.sh
source /cvmfs/cms.cern.ch/rucio/setup-py3.sh

voms-proxy-init --voms cms --valid 168:00 --out $(pwd)/voms_proxy.txt
export X509_USER_PROXY=$(pwd)/voms_proxy.txt
```

2. Put the full CMS dataset paths you want, one per line, in a text file under
   [`datasetsTxtFiles/`](datasetsTxtFiles/) (`#`-comments and blank lines are fine). See
   [Dataset lists](#dataset-lists) below for the ones already in this repo.

3. Run `make_rucio_container.sh` against that file:

```bash
./make_rucio_container.sh [dataset_file] [container_name] [rse] [lifetime_seconds]
# defaults: datasets_2022.txt  /Analyses/Hmumurun3_run3Missing/USER  T2_US_Purdue  31536000
```

It resolves every entry through `dasgoclient`, reports anything DAS can't find, and then
prompts for one of:

- `list` — print the resolved unique dataset names.
- `dry-create` — print the `rucio` commands it would run, without running them.
- `create` — create/reuse the container, attach every resolved dataset, and add a
  replication rule with `--ask-approval`.

Example commands:

```bash
./make_rucio_container.sh datasetsTxtFiles/2025_2026_data.txt /Analyses/Hmumurun3_run3_2025_2026Data/USER T2_US_Purdue
./make_rucio_container.sh datasetsTxtFiles/datasets_2022preEE.txt /Analyses/Hmumurun3_2022preEE/USER T2_US_Purdue
./make_rucio_container.sh datasetsTxtFiles/datasets_2023BPix.txt /Analyses/Hmumurun3_2023BPix/USER T2_US_Purdue
```

4. `rucio rule add ... --ask-approval` files an approval request rather than transferring
   data immediately. Track it at https://cms-rucio-webui.cern.ch/r2d2.

## Dataset lists

All dataset lists live under [`datasetsTxtFiles/`](datasetsTxtFiles/), as plain lists of
full CMS dataset paths (`/PrimaryDataset/ProcessedDataset/DataTier`), one per line:

| File | Contents |
| --- | --- |
| `datasets_2022preEE.txt` | 2022 pre-EE data + MC only |
| `datasets_2022postEE.txt` | 2022 post-EE data + MC only |
| `datasets_2023.txt` | 2023 data + MC |
| `datasets_2023BPix.txt` | 2023 BPix-era data + MC |
| `datasets_2024.txt` | 2024 data + MC |
| `2025_2026_data.txt` | Muon PromptReco data for 2025-2026 |

When adding a new batch of datasets, add or edit one of these text files rather than
writing a new script — `make_rucio_container.sh` is the only script needed to turn a
dataset list into a Rucio container + rule.
