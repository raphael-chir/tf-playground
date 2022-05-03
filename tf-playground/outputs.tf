# ---------------------------------------------
#    Root Module Output return variables
# ---------------------------------------------

output "instance01-ssh" {
  value = join("",["ssh -i ", var.ssh_private_key_path," ec2-user@", module.node01.public_ip])
}