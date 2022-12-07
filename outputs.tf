output "database_host" {
  description = "The hostname of the database"
  value       = aws_db_instance.main_db.address
}

output "load_balancer_url" {
  description = "The load balancer url"
  value       = aws_alb.application_load_balancer.dns_name
}
