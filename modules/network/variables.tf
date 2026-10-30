variable "project" {
  description = "Prefiks på alle ressursnavn og modulen bygges fra, f.eks. \"hhh90\"."
  type        = string
}

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

variable "name_prefix" {
  type = string
}