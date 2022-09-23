resource "system_file" "ppd_brother" {
  path    = "/etc/cups/ppd/Brother_DCP_L3510CDW_series.ppd"
  content = file("files/brother/Brother_DCP_L3510CDW_series.ppd")

  depends_on = [
    system_packages_apk.cups
  ]
}
