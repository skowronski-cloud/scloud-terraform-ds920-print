# print.ds920.ds

VM on DS920 installed from Alpine for VMs ISO with MAC `02:11:32:29:D6:71` and IP `192.168.0.111`

This must be VM as DSM does not support USB attachemnt to Docker containers :(

## what's inside

printers:
- USB: DYMO LabelWriter 450 DUO Label
- USB: DYMO LabelWriter 450 DUO Tape
- USB: Intermec PC43d

services:
- cups with IPP
- avahi for Bonjour

## start work on clear VM

```bash
for l in `terraform state list`; do terraform state rm $l; done
terraform import system_file.apk_repositories /etc/apk/repositories
```
