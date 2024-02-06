resource "openstack_compute_instance_v2" "instance" {
  name            = "teleport-test"
  image_name      = var.image_name
  flavor_name     = var.flavor_name
  key_pair        = openstack_compute_keypair_v2.key_pair.name
  security_groups = [
    openstack_networking_secgroup_v2.ssh.name,
    openstack_networking_secgroup_v2.http.name,
    openstack_networking_secgroup_v2.teleport.name,
  ]

  user_data = file("${path.module}/cloud-init.sh")

  network {
    uuid = openstack_networking_network_v2.private_net.id
  }

}


resource "openstack_networking_floatingip_v2" "floating_ip" {
  pool = var.public_network_name
}

resource "openstack_compute_floatingip_associate_v2" "floating_ip_association" {
  floating_ip = openstack_networking_floatingip_v2.floating_ip.address
  instance_id = openstack_compute_instance_v2.instance.id
}

// Print the Floating IP after the creation
output "instance_fip_address" {
  value = openstack_networking_floatingip_v2.floating_ip.address
}


