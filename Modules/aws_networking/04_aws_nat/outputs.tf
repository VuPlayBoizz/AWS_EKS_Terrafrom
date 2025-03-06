output "nat_gateway_id" {
    value = aws_nat_gateway.nat_gw.id
}
output "nat_gateway_ip" {
    value = "${aws_nat_gateway.nat_gw.public_ip}/32"
}