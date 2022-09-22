resource "system_packages_apk" "lighttpd" {
  package {
    name = "lighttpd"
  }

  depends_on = [
    system_packages_apk.common,
    system_file.lighttpd_conf
  ]
}

resource "system_file" "lighttpd_conf" {
  path    = "/etc/lighttpd/lighttpd.conf"
  content = templatefile("files/lighttpd/lighttpd.conf", {
    ip = var.ip
  })
}

resource "system_file" "AllowInsecureGuestAuth_reg" {
  path    = "/var/www/localhost/htdocs/AllowInsecureGuestAuth.reg"
  content = file("files/lighttpd/AllowInsecureGuestAuth.reg")
}
resource "system_file" "lighttpd_index_html" {
  path    = "/var/www/localhost/htdocs/index.html"
  content = templatefile("files/lighttpd/index.html", {
    ip = var.ip,
    labels = var.labels
  })
}

resource "system_service_openrc" "lighttpd" {
  name    = "lighttpd"
  enabled = true
  status  = "started"

  depends_on = [
    system_packages_apk.common,
    system_packages_apk.lighttpd
  ]

  restart_on = [
    resource.system_file.lighttpd_conf.md5sum
  ]
}

resource "null_resource" "lighttpd_labels" {
  for_each = toset(var.labels)

  connection {
    host     = "${var.ip}"
    type     = "ssh"
    user     = "root"
    private_key = file("~/.ssh/id_ed25519")
  }

  provisioner "file" {
    destination = "/var/www/localhost/htdocs/${each.value}"
    source      = "files/labels/${each.value}"
  }

  triggers = {
    check_labels_htdocs = data.system_command.check_labels_htdocs[each.value].stdout
    local_change = filemd5("files/labels/${each.value}")
  }

  depends_on = [
    system_packages_apk.lighttpd,
    data.system_command.dirs,
    data.system_command.check_labels_htdocs
  ]
}