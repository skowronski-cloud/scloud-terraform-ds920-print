variable "ip" {
  type          = string
  validation {
    condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",var.ip))
    error_message = "Invalid IP address provided."
  }

  default = "192.168.0.111"
}

variable "labels" {
  type = list(string)
  default = [ 
    "12mm.label",
    "24mm.label",
    "large_54x70.label",
    "large_address_36x89.label"
  ]
}

variable "windrv_intermec_files" {
  type = list(string)
  default = [ 
    "Defaults[SS]_2022.1.0.0.sds",
    "Seagull_V3_ConfigDispatcher.dll",
    "Seagull_V3_NetMonDispatcher.dll",
    "Seagull_V3_PrintDispatcher.dll",
    "idpSS_2022.1.0.0.ini",
    "idpSSenu_2022.1.0.0.chm",
    "ss#base_2022.1.0.0.cab",
    "ss#base_2022.1.0.0.ddz",
    "ss#idp_2022.1.0.0.cab",
    "ss#idp_2022.1.0.0.ddz"
  ]
}