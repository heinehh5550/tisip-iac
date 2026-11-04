mock_provider "azurerm" {}

variables {
  name_prefix         = "hhh90-iac"
  location            = "westeurope"
  resource_group_name = "hhh90-iac-dev-rg"
}

run "subnettene_har_riktig_cidr" {
  command = plan

  assert {
    condition     = azurerm_subnet.snet.address_prefixes[0] == "10.0.1.0/24"
    error_message = "Subnettet skal ha CIDR 10.0.1.0/24."
  }

  assert {
    condition     = azurerm_subnet.data.address_prefixes[0] == "10.0.2.0/24"
    error_message = "Data-subnettet skal ha CIDR 10.0.2.0/24."
  }
}

run "navnene_bruker_prefikset" {
  command = plan

  assert {
    condition     = azurerm_virtual_network.vnet.name == "hhh90-iac-vnet"
    error_message = "VNet-navnet skal være <project>-vnet."
  }
}

run "ugyldig_name_prefix_avvises" {
  command = plan

  variables {
    name_prefix = "Tim84 IAC"
  }

  expect_failures = [var.name_prefix]
}

run "ssh_er_ikke_aapent_for_internett" {
  command = plan

  assert {
    condition = alltrue([
      for r in azurerm_network_security_group.this.security_rule :
      r.source_address_prefix != "*" if r.destination_port_range == "22"
    ])
    error_message = "SSH (port 22) skal ikke være åpent fra hele internett."
  }
}