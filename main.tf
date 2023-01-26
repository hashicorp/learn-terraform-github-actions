terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.55.1"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "phorind"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

# connect to your Snowflake account
provider "snowflake" {
    account = "vw14553"
    region = "eu-west-1" # fill-in only if required
    username = "teliaacademy"
    password = "Telia2023" # do not use, we'll set an env var instead
    role = "accountadmin"
}
# create one "my_tf_database.my_tf_schema.my_tf_table" db table
resource "snowflake_database" "database" {
  name      = "my_tf_database"
}
resource "snowflake_schema" "schema" {
  database  = snowflake_database.database.name
  name      = "my_tf_schema"
}
resource "snowflake_table" "table" {
  database  = snowflake_database.database.name
  schema    = snowflake_schema.schema.name
  name      = "my_tf_table"
column {
    name     = "id"
    type     = "int"
  }
  column {
    name     = "data"
    type     = "text"
  }
}
