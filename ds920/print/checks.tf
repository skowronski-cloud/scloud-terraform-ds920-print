data "system_command" "check_labels_htdocs" {
  for_each = toset(var.labels)

  command = "md5sum /var/www/localhost/htdocs/${each.value} || true"
  expect {
    stdout = true
  }
}

data "system_command" "check_labels_samba" {
  for_each = toset(var.labels)

  command = "md5sum /usr/share/dymo/${each.value} || true"
  expect {
    stdout = true
  }
}

data "system_command" "check_drivers" {
  for_each = toset(var.windrv_intermec_files)

  command = "md5sum /var/lib/samba/printers/x64/3/${each.value} || true"
  expect {
    stdout = true
  }
}

data "system_command" "check_registry" {
  command = "md5sum /var/lib/samba/registry.tdb || true"
  expect {
    stdout = true
  }
}