#######################
#         SSH         #
#######################
resource "openstack_networking_secgroup_v2" "ssh" {
  name        = "ssh"
  description = "Allow SSH from anywhere - Recommended to delete after deployment"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol  = "tcp"

  port_range_min   = 22
  port_range_max   = 22
  remote_ip_prefix = "0.0.0.0/0"

  security_group_id = openstack_networking_secgroup_v2.ssh.id
}

#######################
#         HTTP        #
#######################
resource "openstack_networking_secgroup_v2" "http" {
  name        = "http"
  description = "Allow HTTP/HTTPS from anywhere"
}

resource "openstack_networking_secgroup_rule_v2" "http" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol  = "tcp"

  port_range_min   = 80
  port_range_max   = 80
  remote_ip_prefix = "0.0.0.0/0"

  security_group_id = openstack_networking_secgroup_v2.http.id
}

resource "openstack_networking_secgroup_rule_v2" "https" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol  = "tcp"

  port_range_min   = 443
  port_range_max   = 443
  remote_ip_prefix = "0.0.0.0/0"

  security_group_id = openstack_networking_secgroup_v2.http.id
}

#######################
#         TELEPORT        #
#######################
resource "openstack_networking_secgroup_v2" "teleport" {
  name        = "teleport"
  description = "Allow Teleport access from anywhere"
}

resource "openstack_networking_secgroup_rule_v2" "teleport" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol  = "tcp"

  port_range_min   = 3022
  port_range_max   = 3080
  remote_ip_prefix = "0.0.0.0/0"

  security_group_id = openstack_networking_secgroup_v2.teleport.id
}