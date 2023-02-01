resource "opentelekomcloud_networking_network_v2" "network" {
  count          = var.instance_count
  name           = "${var.project}-network"
  admin_state_up = "true"
}

resource "opentelekomcloud_networking_subnet_v2" "subnet" {
  name            = "${var.project}-subnet"
  count           = var.instance_count
  network_id      = opentelekomcloud_networking_network_v2.network.id
  cidr            = var.subnet_cidr
  ip_version      = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}