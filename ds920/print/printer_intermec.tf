resource "system_packages_apk" "intermec" {
  package {
    name =  "netpbm"
  }
  package {
    name =  "g++"
  }
}

resource "system_file" "pbmtodp" {
  path    = "/var/local/pbmtodp.c"
  content = file("files/intermec/pbmtodp.c")
}

data "system_command" "pbmtodp" {
  command = "echo '' | pbmtodp || gcc /var/local/pbmtodp.c -o /usr/bin/pbmtodp -Wall -Wcast-align && true"
  
  depends_on = [
    system_file.pbmtodp,
    system_packages_apk.intermec
  ]
}

resource "system_file" "ppd_intermec" {
  path    = "/etc/cups/ppd/Intermec_PC43d-203-FP.ppd"
  content = file("files/intermec/Intermec_PC43d-203-FP.ppd")

  depends_on = [
    system_packages_apk.cups
  ]
}

resource "system_file" "drv_intermec" {
  path    = "/usr/bin/intermec-dp-drv"
  content = file("files/intermec/intermec-dp-drv")
  mode = "755"

  depends_on = [
    system_packages_apk.cups
  ]
}
