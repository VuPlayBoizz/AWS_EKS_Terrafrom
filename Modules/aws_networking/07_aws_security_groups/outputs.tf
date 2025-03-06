output "control_plane_sg_id" {
    value = aws_security_group.control_plane_sg.id
}

output "worker_node_sg_id" {
    value = aws_security_group.worker_node_sg.id
}

output "public_sg_id" {
    value = aws_security_group.public_sg.id
}