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

resource "null_resource" "windrv_intermec_files_files" {
  for_each = toset(var.windrv_intermec_files)

  connection {
    host     = "${var.ip}"
    type     = "ssh"
    user     = "root"
    private_key = file("~/.ssh/id_ed25519")
  }

  provisioner "file" {

    destination = "/var/lib/samba/printers/x64/3/${each.value}"
    source      = "files/intermec/windows/${each.value}"
  }

  provisioner "file" {
    destination = "/var/lib/samba/registry.tdb"
    source      = "files/samba/registry.tdb"
  }

  triggers = {
    check_drivers = data.system_command.check_drivers[each.value].stdout
    local_change = filemd5("files/intermec/windows/${each.value}")
  }

  depends_on = [
    system_packages_apk.common,
    system_packages_apk.samba,
    data.system_command.dirs,
    data.system_command.check_drivers
  ]
}

resource "null_resource" "samba_registry" {
  connection {
    host     = "${var.ip}"
    type     = "ssh"
    user     = "root"
    private_key = file("~/.ssh/id_ed25519")
  }

  provisioner "file" {
    destination = "/var/lib/samba/registry.tdb"
    source      = "files/samba/registry.tdb"
  }

  triggers = {
    check_drivers = data.system_command.check_registry.stdout
    local_change = filemd5("files/samba/registry.tdb")
  }

  depends_on = [
    system_packages_apk.common,
    system_packages_apk.samba,
    data.system_command.dirs,
    data.system_command.check_registry
  ]
}
