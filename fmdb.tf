resource "keycloak_openid_client" "FMDB" {
  access_type = "CONFIDENTIAL"
  # backchannel_logout_revoke_offline_sessions = false
  backchannel_logout_session_required = false
  base_url                            = "https://fmdbd.hlth.gov.bc.ca/FMDB"
  client_authenticator_type           = "client-secret"
  client_id                           = "FMDB"
  consent_required                    = false
  description                         = "Formulary Management Database"
  direct_access_grants_enabled        = false
  # display_on_consent_screen                  = false
  enabled = true
  # extra_config                               = {}
  frontchannel_logout_enabled = false
  full_scope_allowed          = false
  implicit_flow_enabled       = false
  name                        = "FMDB"
  # oauth2_device_authorization_grant_enabled  = false
  realm_id                 = "moh_applications"
  service_accounts_enabled = false
  standard_flow_enabled    = true
  use_refresh_tokens       = false
  valid_redirect_uris = [
    "http://localhost:8080/*",
    "https://fmdbd.hlth.gov.bc.ca/*",
    "https://localhost:8081/*",
    "https://logontest7.gov.bc.ca/clp-cgi/logoff.cgi*",
  ]
  web_origins = []
  admin_url   = ""
}

resource "keycloak_role" "MOHUSER" {
  realm_id    = "moh_applications"
  client_id   = keycloak_openid_client.FMDB.id
  name        = "MOHUSER"
  description = "The base user permission for FMDB"
}

resource "keycloak_role" "PSDADMIN" {
  realm_id    = "moh_applications"
  client_id   = keycloak_openid_client.FMDB.id
  name        = "PSDADMIN"
  description = "Admin role for FMDB provides access to code table management"
}

resource "keycloak_role" "MYNEWROLE" {
  realm_id    = "moh_applications"
  client_id   = keycloak_openid_client.FMDB.id
  name        = "MYNEWROLE"
  description = "A new role for a demonstration."
}


#resource "keycloak_openid_client_default_scopes" "FMDB_client_default_scopes" {
#  realm_id  = keycloak_openid_client.FMDB.realm_id
#  client_id = keycloak_openid_client.FMDB.id
#  default_scopes = [
#    "web-origins",
#    "profile"
#  ]
#}

resource "keycloak_openid_user_client_role_protocol_mapper" "FMDB_Role_user_client_role_mapper" {
  realm_id   = keycloak_openid_client.FMDB.realm_id
  client_id  = keycloak_openid_client.FMDB.id
  name       = "FMDB Role"
  claim_name = "fmdb_role"

  add_to_access_token         = true
  add_to_id_token             = false
  add_to_userinfo             = false
  claim_value_type            = "String"
  client_id_for_role_mappings = "FMDB"
  multivalued                 = true
}
