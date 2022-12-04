# aws default
variable "emr_subnet_id" {
  description = "EMR subnet id"
  type = string
}

variable "emr_role_name" {
  description = "EMR service role name"
  type = string
}

variable "ec2_instance_role_name" {
  description = "EMR EC2 instance role name"
  type = string
}

variable "emr_autoscaling_policy_role_name" {
  description = "auto_scaling_policy_name"
  type = string
}

variable "ec2_instance_key_pair_name" {
  description = "key pair name for instance"
  type = "string"
}



## EMR setting default
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}
variable "emr_name" {
  description = "EMR pipeline name"
  type        = string
  default     = "emr-pipeline"
}
variable "emr_release_label" {
  description = "EMR release label"
  type        = string
}
variable "emr_applications" {
  description = "EMR install application"
  type        = list(string)
  default     = [ "Spark", "Hadoop" ]
}

## master instance configure
variable "master_instance_group_instance_type" {
  description = "EC2 instance type for all instances in the Master instance group"
  type        = string
}

variable "master_instance_group_instance_count" {
  description = "Target number of instances for the Master instance group. Must be at least 1"
  type        = number
  default     = 1
}

variable "master_instance_group_ebs_size" {
  description = "Master instances volume size, in gibibytes (GiB)"
  type        = number
  default     = 10
}
variable "master_instance_group_ebs_type" {
  description = "Master instances volume type. Valid options are `gp2`, `io1`, `standard` and `st1`"
  type        = string
  default     = "gp2"
}
variable "master_instance_group_ebs_volumes_per_instance" {
  description = "Master instances volume type. Valid options are `gp2`, `io1`, `standard` and `st1`"
  type        = number
  default     = 1
}


## core instance configure
variable "core_instance_group_instance_type" {
  description = "EC2 instance type for all instances in the Core instance group"
  type        = string
}

variable "core_instance_group_instance_count" {
  description = "Target number of instances for the Core instance group. Must be at least 1"
  type        = number
  default     = 1
}

variable "core_instance_group_ebs_size" {
  description = "Core instances volume size, in gibibytes (GiB)"
  type        = number
  default     = 10
}
variable "core_instance_group_ebs_type" {
  description = "Core instances volume type. Valid options are `gp2`, `io1`, `standard` and `st1`"
  type        = string
  default     = "gp2"
}
variable "core_instance_group_ebs_volumes_per_instance" {
  description = "Core instances volume type. Valid options are `gp2`, `io1`, `standard` and `st1`"
  type        = number
  default     = 1
}

## task instance configure
variable "create_task_instance_group" {
  description = "Whether to create an instance group for Task nodes"
  type        = bool
  default     = false
}
variable "task_instance_group_instance_type" {
  description = "EC2 instance type for all instances in the Task instance group"
  type        = string
  default     = null
}

variable "task_instance_group_instance_count" {
  description = "Target number of instance for the Task instance group."
  type = number
  default = 1
}


variable "task_instance_group_instance_min_count" {
  description = "Target minimum number of instances for the Task instance group."
  type        = number
  default     = 0
}
variable "task_instance_group_instance_max_count" {
  description = "Target maximum number of instances for the Task instance group."
  type        = number
  default     = 1
}

### task instance auto scaling
variable "task_scale_out_yarn_memory_available_percentage" {
  description = "Scale out yarn memory available"
  type        = number
  default     = 15
}

variable "task_scale_out_container_pending_ratio" {
  description = "Scale out container pending ratio"
  type        = number
  default     = 0.75
}

variable "task_scale_in_yarn_memory_available_percentage" {
  description = "Scale in yarn memory available"
  type        = number
  default     = 75
}


### etc
variable "ssh_public_key_path" {
  description = "pem file path"
  type = string
}

