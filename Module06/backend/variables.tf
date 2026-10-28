# =============================================================================
#  backend/variables.tf  –  BOOTSTRAP-STACKEN
# -----------------------------------------------------------------------------
#  Tre variabler, og ikke flere. Alt annet i denne stacken er bevisst likt for
#  alle: containeren heter alltid "tfstate", replikeringen er alltid LRS, og
#  retensjonen er alltid 7 dager. Det som ikke skal kunne variere, skal heller
#  ikke være en variabel – hver variabel er en beslutning du sender videre til
#  den som kjører koden.
# =============================================================================

variable "kortnavn" {
  description = <<-EOT
    Ditt unike kortnavn. Små bokstaver og tall, 3–8 tegn.
    Den havner rett inn i et storage account-navn ("stdemo" + kortnavn), og
    det er derfor grensene er strammere her enn i øving 4. Et storage
    account-navn må være 3–24 tegn, kun små alfanumeriske, og globalt unikt i
    hele Azure.
  EOT
  type        = string

  validation {
    # Regexen er ikke pynt: uten den feiler apply først inne i Azure, med en
    # melding om at navnet er ugyldig – og da har du allerede opprettet
    # ressursgruppa. Valideringen flytter feilen fram til plan.
    condition     = can(regex("^[a-z0-9]{3,8}$", var.kortnavn))
    error_message = "kortnavn må være 3–8 tegn, kun små bokstaver og tall."
  }
}

variable "location" {
  description = "Azure-region backenden opprettes i. Bruk samme region som i nettverksprosjektet."
  type        = string
  default     = "norwayeast"

  validation {
    condition     = contains(["norwayeast", "westeurope", "northeurope", "uksouth"], var.location)
    error_message = "Regionen må være én av: norwayeast, westeurope, northeurope, uksouth (Azure Policy i fagets tenant)."
  }
}

variable "pipeline_principal_id" {
  description = <<-EOT
    OBJECT-IDen til SERVICE PRINCIPAL-EN bak App Registration-en din.
    Tre IDer forveksles her, og bare én av dem er riktig:
      Application (client) ID  – identifiserer App Registration-en (definisjonen)
      Object ID på Overview    – tilhører App Registration-OBJEKTET
      Object ID på service     – DENNE. Rolletildelinger peker alltid hit.
        principal-en
    Hentes slik, innlogget mot fagets tenant:
      az ad sp list --display-name "<dinAppName>" --query "[].id" --output tsv
    og kontrolleres slik:
      az ad sp show --id <client-id> --query id -o tsv
  EOT
  type        = string

  validation {
    # Denne valideringen fanger IKKE at du har brukt feil GUID – alle tre IDene
    # har samme form. Den fanger at du har limt inn noe som ikke er en GUID i
    # det hele tatt, f.eks. appens visningsnavn. Resten må du kontrollere selv,
    # med kommandoen i beskrivelsen over.
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.pipeline_principal_id))
    error_message = "pipeline_principal_id må være en GUID (36 tegn). Se beskrivelsen for hvordan du finner riktig verdi."
  }
}

# -----------------------------------------------------------------------------
#  Tagger
# -----------------------------------------------------------------------------
locals {
  tags = {
    student = var.kortnavn
    course  = "iac"

    # keep = "true" ER IKKE PYNT.
    #
    # I den delte subscriptionen kjører det opprydding som river ressurser som
    # ikke er i bruk. Backend-stacken skal OVERLEVE den oppryddingen, og taggen
    # er signalet om at den skal stå.
    #
    # Alle tre ressursene må ha den. Forsvinner storage-kontoen, forsvinner
    # oversikten over alt som ligger i backenden – og modul 7 begynner forfra.
    keep = "true"
  }
}