# Output to show user what IP address will be used to access the nginx resource
output "ip" {
  value = aws_eip.tadc_ip.public_ip
}