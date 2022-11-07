output "vpc-id" {
  value = aws_vpc.vpc.id
}
output "subnet-id1" {
  value = aws_subnet.pubsn1.id
}
output "subnet-id2" {
  value = aws_subnet.pubsn2.id
}
output "subnet-id3" {
  value = aws_subnet.prvsn1.id
}
output "subnet-id4" {
  value = aws_subnet.prvsn2.id
}
output "subnet-id5" {
  value = aws_subnet.prvsn3.id
}
output "subnet-id6" {
  value = aws_subnet.prvsn4.id
}