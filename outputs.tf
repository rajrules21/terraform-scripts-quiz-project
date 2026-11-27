output "bucket_name" {
  value = module.s3.bucket_name
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "route_table_id" {
  value = module.vpc.route_table_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "Public DNS name of the Application Load Balancer"
}

output "ecr_repository_name" {
  value = module.ecr.ecr_repository_name
}

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}

output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}

output "ecs_service_name" {
  value = module.ecs.ecs_service_name
}

output "codepipeline_arn" {
  value = module.codepipeline.codepipeline_arn
}
