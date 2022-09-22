resource "system_file" "ppd_dymo_label" {
  path    = "/etc/cups/ppd/DYMO_LabelWriter_450_DUO_Label.ppd"
  content = file("files/dymo/DYMO_LabelWriter_450_DUO_Label.ppd")

  depends_on = [
    data.system_command.dirs
  ]
}
resource "system_file" "ppd_dymo_tape" {
  path    = "/etc/cups/ppd/DYMO_LabelWriter_450_DUO_Tape.ppd"
  content = file("files/dymo/DYMO_LabelWriter_450_DUO_Tape.ppd")

  depends_on = [
    data.system_command.dirs
  ]
}


resource "system_file" "dymo_downloader" {
  path    = "/usr/share/dymo/dymo_downloader.sh"
  content = file("files/dymo/dymo_downloader.sh")

  depends_on = [
    data.system_command.dirs
  ]
}

data "system_command" "dymo_downloader" {
  command = "bash /usr/share/dymo/dymo_downloader.sh"

  depends_on = [
    system_file.dymo_downloader
  ]
}

resource "null_resource" "samba_labels" {
  for_each = toset(var.labels)

  connection {
    host     = "${var.ip}"
    type     = "ssh"
    user     = "root"
    private_key = file("~/.ssh/id_ed25519")
  }

  provisioner "file" {
    destination = "/usr/share/dymo/${each.value}"
    source      = "files/labels/${each.value}"
  }

  triggers = {
    check_labels_samba = data.system_command.check_labels_samba[each.value].stdout
  }

  depends_on = [
    system_packages_apk.samba,
    data.system_command.dirs,
    data.system_command.check_labels_samba
  ]
}