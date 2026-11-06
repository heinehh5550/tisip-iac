
variable "location" {
  description = "Azure-regionen for ressursen"
  type        = string
}

variable "resource_group_name" {
  description = "Navnet på ressursgruppen som eksisterer eller skal opprettes"
  type        = string
}

variable "tags" {
  description = "Tags som skal settes på ressursene"
  type        = map(string)
  default     = {}
}

variable "address_space" {
  description = "CIDR-blokken som skal brukes for det virtuelle nettverket"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  description = "CIDR-blokken som skal brukes for subnettet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "data_subnet_address_prefix" {
  description = "Adresseområdet til data-subnettet. Må ligge innenfor address_space og ikke overlappe subnettet over."
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "name_prefix" {
  description = "Prefiks som brukes ved navngivning av ressursene i nettverksmodulen, f.eks. hhh90-dev."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.name_prefix))
    error_message = "project kan bare inneholde små bokstaver, tall og bindestrek (3–20 tegn)."
  }
}

variable "ssh_source_prefix" {
  type        = string
  description = "Hvor SSH (port 22) er tillatt fra. Aldri \"*\"."
  default     = "VirtualNetwork" # Azure-tag: bare trafikk fra eget VNet
}
