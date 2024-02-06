data "openstack_networking_network_v2" "public_net" {
  name = var.public_network_name
}

resource "openstack_networking_network_v2" "private_net" {
  name           = "teleport-private-net"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "private_subnet" {
  name            = "teleport-private-subnet"
  network_id      = openstack_networking_network_v2.private_net.id
  cidr            = "192.168.10.0/24"
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}

resource "openstack_networking_router_v2" "router" {
  name                = "router"
  external_network_id = data.openstack_networking_network_v2.public_net.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.private_subnet.id
}
