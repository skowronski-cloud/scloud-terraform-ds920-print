resource "system_packages_apk" "cups" {
  package {
    name = "cups"
    version = "=2.3.3-r2" # newer ones can't expose drivers properly
  }

  package {
    name = "ghostscript"
  }

  depends_on = [
    system_packages_apk.common,
    system_file.cupsd_conf,
    system_file.printers_conf
  ]
}

resource "system_file" "cupsd_conf" {
  path    = "/etc/cups/cupsd.conf"
  content = templatefile("files/cups/cupsd.conf", {
    ip = var.ip
  })

  depends_on = [
    data.system_command.dirs
  ]
}

resource "system_file" "printers_conf" {
  path    = "/etc/cups/printers.conf"
  content = templatefile("files/cups/printers.conf", {})

  depends_on = [
    data.system_command.dirs
  ]
}

resource "system_service_openrc" "cupsd" {
  name    = "cupsd"
  enabled = true
  status  = "started"
  
  restart_on = [
    resource.system_file.cupsd_conf.md5sum,
    resource.system_file.printers_conf.md5sum
  ]

  depends_on = [
    system_packages_apk.cups
  ]
}
