output "vpc_id" {
  value       = aws_vpc.anz_vpc.id
  description = "id of the created vpc"
}

output "vpc_cidr_block" {
  value       = aws_vpc.anz_vpc.cidr_block
  description = "cidr block of the created vpc"
}

output "pub_subnet_id" {
  value       = aws_subnet.anz_public.id
  description = "id of the created public subnet"
}

output "pri_subnet_id" {
  value       = aws_subnet.anz_private.id
  description = "id of the created private subnet"
}
