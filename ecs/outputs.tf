output "ecs_cluster_id" {
  value = aws_ecs_cluster.my_ecs_cluster.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.my_ecs_cluster.name
}

output "ecs_service_name" {
  value = aws_ecs_service.my_ecs_service.name
}
