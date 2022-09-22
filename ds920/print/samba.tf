resource "system_packages_apk" "samba" {
  package {
    name = "samba"
  }

  depends_on = [
    system_packages_apk.common,
    system_file.smb_conf
  ]
}

resource "system_service_openrc" "samba" {
  name    = "samba"
  enabled = true
  status  = "started"

  depends_on = [
    system_packages_apk.common,
    system_packages_apk.samba
  ]

  restart_on = [
    resource.system_file.smb_conf.md5sum
  ]
}

resource "system_file" "smb_conf" {
  path    = "/etc/samba/smb.conf"
  content = templatefile("files/samba/smb.conf", {
    ip = var.ip
  })
}
