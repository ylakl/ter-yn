terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.139.0"
    }
  }
}

provider "yandex" {
   token              = "y0__xDl0-yUBBjB3RMgrp3gxRLzqkdKSpIfDjzrCHk9VJmVxCCScQ"
   cloud_id           = "b1guukrlolhh89d8t696"
   folder_id          = "b1gctg2bhvuagrakii2l"
   zone               = "ru-central1-d"
}
resource "yandex_compute_instance" "instance-based-on-coi" {
  name        = "test"
  platform_id = "standard-v3"

  resources {
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk" 
      size     = 10
    }
  }

  network_interface {
    subnet_id = "fl87t36qv5u0h81cntot"
    nat       = true
  }
  metadata = {
   docker-container-declaration = file("${path.module}/declaration.yaml")
   user-data = file("${path.module}/cloud_config.yaml")
  }
}
