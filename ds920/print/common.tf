resource "system_file" "apk_repositories" {
  path    = "/etc/apk/repositories"
  content = templatefile("files/alpine/repositories", {})
}


data "system_command" "upgrade" {
  command = "apk update && apk upgrade"
  depends_on = [
    system_file.apk_repositories
  ]
}

data "system_command" "dirs" {
  command = "mkdir -p /usr/share/dymo/ /var/www/localhost/htdocs /etc/samba/ /etc/cups/ppd/ /var/lib/samba/printers/x64/3 /etc/lighttpd/"
  
  depends_on = [
    system_packages_apk.common
  ]
}

resource "system_packages_apk" "common" {
  package {
    name = "bash"
  }

  package {
    name = "dbus"
  }

  depends_on = [
    data.system_command.upgrade
  ]
}


