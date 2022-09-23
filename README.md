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
- samba with Point and Print drivers

## licensing


For obvious reasons following files are not copyrighted by Daniel Skowroński:

- `files/brother/Brother_DCP_L3510CDW_series.ppd`, `files/intermec/Intermec_PC43d-203-FP.ppd` - **CUPS project** - *Copyright © 2007-2022 Apple Inc. CUPS 2.2 and earlier are provided under the terms of the GNU GPL2 and LGPL2 with exceptions while CUPS 2.3 and later are provided under the terms of the Apache License, Version 2.0. CUPS, the CUPS logo, and macOS are trademarks of Apple Inc.* 
- `files/dymo/` - **DYMO LabelWriter Drivers** - *Copyright (C) 2008 Sanford L.P. - This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.*
  - `DYMO_LabelWriter_450_DUO_Label.ppd`
  - `DYMO_LabelWriter_450_DUO_Tape.ppd`
  - `raster2dymolm`
  - `raster2dymolw`
- `files/intermec/pbmtodp.c` - **Conversion from plain PBM/PNM one-bit bitmap format to Intermec Direct Protocol PRBUF RLL/RLE bitmap image format.** - *Copyright (c) 2012, Intermec Technologies Corp. All rights reserved. - The BSD 3-Clause License (as in source file)*


## development

### references

- https://registry.terraform.io/providers/neuspaces/system/latest/docs

### init workspace

```bash
cd files/intermec/windows/; bash download.sh; cd -
```

### start work on clear VM

```bash
for l in `terraform state list`; do terraform state rm $l; done
terraform import system_file.apk_repositories /etc/apk/repositories
```

## TODO

### tf

- better way of trigger+depends_on to watch changes on both sides

### cups

- `version = "=2.3.3-r2"` # newer ones can't expose drivers properly
- cups-browsed not needed

### DYMO

- replace with source from https://www.dymo-label-printers.co.uk/news/download-dymo-sdk-for-linux.html

### windows

- https://opensource.apple.com/source/samba/samba-56/samba/docs/htmldocs/Samba-HOWTO-Collection.html
- https://www.samba.org/samba/docs/current/man-html/rpcclient.1.html
- https://wiki.samba.org/index.php/Setting_up_Automatic_Printer_Driver_Downloads_for_Windows_Clients
- https://wiki.samba.org/index.php/TDB_Locations
- https://www.linuxtopia.org/online_books/network_administration_guides/samba_reference_guide/29_CUPS-printing_105.html

```
runas /netonly /user:PRINT\daniel "mmc printmanagement.msc"
rpcclient localhost -U daniel -c 'setdriver "Intermec_Label" "Intermec PC43d (203 dpi) - DP"'
```