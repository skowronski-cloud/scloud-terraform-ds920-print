terraform {
  required_providers {
    system = {
      source = "neuspaces/system"
    }
  }
}

provider "system" {
  ssh {
    host        = var.ip
    port        = 22
    user        = "root"
    private_key = file("~/.ssh/id_ed25519")
  }
}