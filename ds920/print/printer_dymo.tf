resource "system_file" "ppd_dymo_label" {
  path    = "/etc/cups/ppd/DYMO_LabelWriter_450_DUO_Label.ppd"
  content = file("files/dymo/DYMO_LabelWriter_450_DUO_Label.ppd")

  depends_on = [
    system_packages_apk.cups
  ]
}
resource "system_file" "ppd_dymo_tape" {
  path    = "/etc/cups/ppd/DYMO_LabelWriter_450_DUO_Tape.ppd"
  content = file("files/dymo/DYMO_LabelWriter_450_DUO_Tape.ppd")

  depends_on = [
    system_packages_apk.cups
  ]
}
