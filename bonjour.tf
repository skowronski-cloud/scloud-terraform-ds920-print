resource "system_packages_apk" "avahi" {
  package {
    name = "avahi"
  }

  depends_on = [
    system_packages_apk.common
  ]
}

resource "system_service_openrc" "avahi" {
  name    = "avahi-daemon"
  enabled = true
  status  = "started"

  depends_on = [
    system_packages_apk.common,
    system_packages_apk.avahi
  ]
}
