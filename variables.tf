### VPC Details 

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "ap-southeast-2"
}

variable "CIDRBlock" {
  description = "The CIDR of the main vpc"
  default = "20.0.0.0/16"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

### ALB Details

variable "health_check_path" {
  default = "/"
}

### ECS Details 

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "testEcsTaskExecutionRole"
}
variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "wordpress"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 2
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

### RDS Database Details

#variable "rds_aurora_subnets" {
#  type        = list(string)
#  description = "List of subnets for RDS to be present"
#}

# Variables with default values set

variable "engine" {
  type        = string
  description = "Aurora DB engine"
  default     = "aurora-mysql"
}

variable "engine_mode" {
  type        = string
  description = "Aurora DB engine mode"
  default     = "serverless"
}

variable "engine_version" {
  type        = string
  description = "Aurora DB engine version"
  default     = "5.7.mysql_aurora.2.03.2"
}

variable "db_name" {
  type    = string
  default = "wordpress"
}

variable "db_user" {
  type = string
  description = "db_username for the application"
  default = "admin"
}

variable "db_parameter_name" {
  type    = string
  default = "/wordpress/WORDPRESS_DB_NAME"
}

variable "db_host_parameter_name" {
  type    = string
  default = "/wordpress/WORDPRESS_DB_HOST"
}

variable "db_user_parameter_name" {
  type    = string
  default = "/wordpress/WORDPRESS_DB_USER"
}

variable "db_pw_parameter_name" {
  type    = string
  default = "/wordpress/WORDPRESS_DB_PASSWORD"
}

variable "backup_retention_period" {
  type        = number
  description = "Reteintion days for backups"
  default     = 1
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Take snapshots before delete"
  default     = true
}

variable "aurora_port" {
  type    = number
  default = 3306
}

# TODO: read this from data
variable "availability_zones" {
  type    = list(string)
  default = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "auto_pause" {
  type    = bool
  default = true
}

variable "max_capacity" {
  type    = number
  default = 1
}

variable "min_capacity" {
  type    = number
  default = 1
}

variable "seconds_until_auto_pause" {
  type    = number
  default = 300
}

variable "timeout_action" {
  type    = string
  default = "ForceApplyCapacityChange"
}
