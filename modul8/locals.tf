locals {
  # Ett felles navnemønster som alle ressursnavn bygges fra
  name_prefix = "${var.kortnavn}-${var.project}"

  common_tags = {
    owner  = var.kortnavn
    course = "iac"
    module = "modul8"
    #ManagedBy forteller den som finner ressursen i portalen at den ikke skal
    #endres for hånd - endringer gjøres i koden, ellers oppstår drift.  
    ManagedBy = "pipeline"
  }
}
