output "rds_endpoint" {
  description = "The domain name of the RDS cluster"
  value       = aws_db_instance.dev_db.address
}
