#!/bin/bash

ver_major="2022"
ver_minor="1"

rm "Honeywell_${ver_major}.${ver_minor}.exe"
wget "https://d94r2itylgwnp.cloudfront.net/Drivers/${ver_major}/${ver_major}.${ver_minor}/Honeywell_${ver_major}.${ver_minor}.exe"

rm -Rf extracted/
7z X "Honeywell_${ver_major}.${ver_minor}.exe" -oextracted

cp "extracted/Common/Defaults[SS]_${ver_major}.${ver_minor}.0.0.sds" .
cp "extracted/Common/idpSS_${ver_major}.${ver_minor}.0.0.ini" .
cp "extracted/Common/idpSSenu_${ver_major}.${ver_minor}.0.0.chm" .
cp "extracted/Common/ss#base_${ver_major}.${ver_minor}.0.0.ddz" .
cp "extracted/Common/ss#idp_${ver_major}.${ver_minor}.0.0.ddz" .
cp "extracted/x64/Seagull_V3_ConfigDispatcher.dll" .
cp "extracted/x64/Seagull_V3_NetMonDispatcher.dll" .
cp "extracted/x64/Seagull_V3_PrintDispatcher.dll" .
cp "extracted/x64/ss#base_${ver_major}.${ver_minor}.0.0.cab" .
cp "extracted/x64/ss#idp_${ver_major}.${ver_minor}.0.0.cab" .

rm "Honeywell_${ver_major}.${ver_minor}.exe"
rm -Rf extracted/

checksums_expected="MTc3YWIyNDQ5MDUzZDA1NGFkYTQ0YzRmZWI3ODZhZWY2ZWU4ZGNkODM2NTE5YmVmZTNlNmYzZTE2ZjEwZTVmZCAuL3NzI2Jhc2VfMjAyMi4xLjAuMC5jYWIKMzFiYzM2MTM4OTc0YTZiMTE0ZWE5ODY0M2I1ZWMzNjczMzA2NDQ4ZDE5Zjc3MTA1Njc5MGEyYjljZWE0NzhkYiAuL1NlYWd1bGxfVjNfTmV0TW9uRGlzcGF0Y2hlci5kbGwKMzYzZDNiYTA5ZjliNjg3ZGE5MGJlZGZjY2I2M2Y5ZTM0NmZjZDAyYTFiMDNkOTg1YjVmYmRjYjFkZTZkYmQyYiAuL3NzI2lkcF8yMDIyLjEuMC4wLmRkegozZjk3N2NiNjk3MzNmOGU2YjFmYTdhNGFkN2NlODBkM2ZkZThkODI3NjYyZTRlMThjNDU3YWRlYzdhNWE2YThkIC4vU2VhZ3VsbF9WM19Db25maWdEaXNwYXRjaGVyLmRsbAo1M2U3NmYzZjRkOWE5OWEyNGI5NDBmMGNlODBkMjhkNjM1NWFmYzBjNzQ2ZGFhNmQzNmJkMzhlNjc5NjI5YmExIC4vaWRwU1NlbnVfMjAyMi4xLjAuMC5jaG0KNTZhYWRiM2U3MmZkNzU4NDdhMDEyMzlkOGVmMmY4ZDI3MTY2MGRkNjcwNWY4MzM3ODNhNjlmMzkyZjIxOWY1MSAuL2Rvd25sb2FkLnNoCjU4MDYwM2FjNmNkMzk2YTJkYzI0NzY0MDM5M2ZiNDEwYzA0NzM4MTc5YTM2YTMxYjkwNmI4NWU5ZTdhZGEzYzUgLi9EZWZhdWx0c1tTU11fMjAyMi4xLjAuMC5zZHMKNjVkMzgyODkyZjY4MzFiYzM4NmZkYWY0MTNjZmMzZDcwOWEyMDcxMTY5MDA5YWYzYjQ2OTkzYTc5ZjhmM2EzNCAuL3NzI2lkcF8yMDIyLjEuMC4wLmNhYgo4ODI5YjdkZDllM2ZhYTVkN2NkNWI5OGYzOGMxZDgzZTAwOWQzMTM2OTg4NDU2YTQyYWJmNTEzNjQ5N2YzZTQwIC4vaWRwU1NfMjAyMi4xLjAuMC5pbmkKYTZmZjk0MGFkMDE2OTU2NzdmNjBjN2QyMTk0Y2JhMGU1OTBiMDVlNGY2MTM5N2U4YzRhYjI1YTA0MDlmMjdhZiAuL1NlYWd1bGxfVjNfUHJpbnREaXNwYXRjaGVyLmRsbAphYTY3NGRjY2YwMmZhMzBmMzU1YmJiNjIwZWQ5MzQ0ODMwZmZhYjFkY2NmODgzMzJmYzkwYTA5NmI5ZTkzOTg1IC4vc3MjYmFzZV8yMDIyLjEuMC4wLmRkego="
checksums_actual=`find . -type f -exec sha256sum {} \; | grep -v .DS_Store | sort | awk '{print $1" "$2}' | base64`

if [[ $checksums_expected == $checksums_actual ]]; then 
	echo "checksum check OK"
else 
	echo "checksum check FAIL"
fi
