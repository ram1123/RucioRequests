# RucioRequests

Steps:

1. Setup proxy:

```bash
voms-proxy-init --voms cms --valid 168:00 --out $(pwd)/voms_proxy.txt
export X509_USER_PROXY=$(pwd)/voms_proxy.txt
```

2. Create container and add datasets:

```bash
./make_rucio_container.sh datasets.txt /Analyses/Hmumurun3_run3/USER T2_US_Purdue
```

Example commands:

```bash
./make_rucio_container.sh 2025_data.txt /Analyses/Hmumurun3_run3_2025Data/USER T2_US_Purdue
./make_rucio_container.sh 2026_data.txt /Analyses/Hmumurun3_run3_2026Data/USER T2_US_Purdue
```
