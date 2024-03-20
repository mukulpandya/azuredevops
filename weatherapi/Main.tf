# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = "tf_rg_blobstore"
    storage_account_name = "tfstoragemukulpandya"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
  
}

variable imagebuild {
  type        = string
  description = "latest image build"
}


resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "South India"
}

resource "azurerm_container_group" "tfcg_test" {
    name = "weatherapi"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_address_type = "Public"
    dns_name_label = "mukulpandyawa"
    os_type = "Linux"

    container {
        name = "weatherapi"
        image = "mukulpandya1981/weatherapi:${var.imagebuild}"
          cpu = "1"
          memory = "1"

          ports {
            port = 80
            protocol = "TCP"
          }
    }
}
