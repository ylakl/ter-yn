terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.139.0"
    }
  }
}

provider "yandex" {
  token     = "t1.9euelZqPyZiRmpuclMzImsvKxoqUzO3rnpWazJeRms-Mx8nIiYmNycnHlY7l8_c7CR9B-e84XmJL_d3z93s3HEH57zheYkv9zef1656VmpLKy5mXxsyZis2cxpXKkpyJ7_zF656VmpLKy5mXxsyZis2cxpXKkpyJ.LC_uRUxwki7m_IYGAuYG4gHxu3Et83pI0RaQM40mtekF5M6_u54v0Ior56ZjKVwgY2-aTZnp61W9zsTfOWjKDg"
  cloud_id  = "b1guukrlolhh89d8t696"
  folder_id = "b1gctg2bhvuagrakii2l"
  zone      = "ru-central1-d"
}
resource "yandex_compute_instance" "vm" {
  name = "terraform1"
  platform_id = "standard-v3"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk" //ubuntu-2004-lts
      size     = 10
    }
  }
  network_interface {
    subnet_id = "fl896vf7uql0nbq510ll"
    nat = true
  }
 
  metadata = {
    docker-container-declaration = file("${path.module}/declaration.yaml")
    user-data = file("${path.module}/cloud_config.yaml")
  }
}
