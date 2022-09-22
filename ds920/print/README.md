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

## usage

### macOS

Just use system tools, eveyrthing is available via Bonjour.

### Windows

1. Connect to `\\192.168.0.111`
   1. If there's error `Microsoft Windows Network: you cannot access this shared folder because your organisation's security policies block unauthenticated guest access.` the you need to 

## development

### references

- https://registry.terraform.io/providers/neuspaces/system/latest/docs

### start work on clear VM

```bash
for l in `terraform state list`; do terraform state rm $l; done
terraform import system_file.apk_repositories /etc/apk/repositories
```

## TODO

### tf

- better way of trigger+depends_on to watch changes on both sides

### cups
- version = "=2.3.3-r2" # newer ones can't expose drivers properly
- cups-browsed not needed

### win

- https://opensource.apple.com/source/samba/samba-56/samba/docs/htmldocs/Samba-HOWTO-Collection.html
- https://www.samba.org/samba/docs/current/man-html/rpcclient.1.html
- https://wiki.samba.org/index.php/Setting_up_Automatic_Printer_Driver_Downloads_for_Windows_Clients
- https://wiki.samba.org/index.php/TDB_Locations
- https://www.linuxtopia.org/online_books/network_administration_guides/samba_reference_guide/29_CUPS-printing_105.html

```
runas /netonly /user:PRINT\daniel "mmc printmanagement.msc"
rpcclient localhost -U daniel -c 'setdriver "Intermec_Label" "Intermec PC43d (203 dpi) - DP"'
```