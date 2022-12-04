terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.45"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "default"
}

data "aws_iam_instance_profile" "ec2-instance-role"{
  name = var.ec2_instance_role_name
}

data "aws_iam_role" "emr-role" {
  name = var.emr_role_name
}

data "aws_iam_role" "auto-scaling-role" {
  name = var.emr_autoscaling_policy_role_name
}

resource "aws_emr_cluster" "emr-cluster-with-terraform" {
  name          = var.emr_name
  release_label = var.emr_release_label
  applications  = var.emr_applications

  termination_protection            = false
  keep_job_flow_alive_when_no_steps = true
  ec2_attributes {
    subnet_id        = var.emr_subnet_id
    instance_profile = data.aws_iam_instance_profile.ec2-instance-role.arn
    key_name         = var.ec2_instance_key_pair_name
  }

  master_instance_group {
    name           = "master-instance-group"
    instance_type  = var.master_instance_group_instance_type
    instance_count = var.master_instance_group_instance_count
    ebs_config {
      size                 = var.master_instance_group_ebs_size
      type                 = var.master_instance_group_ebs_type
      volumes_per_instance = var.master_instance_group_ebs_volumes_per_instance
    }
  }

  core_instance_group {
    name           = "core-instance-group"
    instance_type  = var.core_instance_group_instance_type
    instance_count = var.core_instance_group_instance_count
    ebs_config {
      size                 = var.core_instance_group_ebs_size
      type                 = var.core_instance_group_ebs_type
      volumes_per_instance = var.core_instance_group_ebs_volumes_per_instance
    }
  }
  tags = {
    env = "dev"
  }

  service_role = data.aws_iam_role.emr-role.arn
  autoscaling_role = data.aws_iam_role.auto-scaling-role.arn
}

resource "aws_emr_instance_group" "task" {
  name = "task-instance-group"
  cluster_id    = aws_emr_cluster.emr-cluster-with-terraform.id
  instance_type = var.task_instance_group_instance_type
  instance_count = var.task_instance_group_instance_count
  bid_price = "0.304"
  autoscaling_policy = <<EOF
{
"Constraints": {
  "MinCapacity": ${var.task_instance_group_instance_min_count},
  "MaxCapacity": ${var.task_instance_group_instance_max_count}
},
"Rules": [
  {
    "Name": "ScaleOutMemoryPercentage",
    "Description": "Scale out if YARNMemoryAvailablePercentage is less than 15",
    "Action": {
      "SimpleScalingPolicyConfiguration": {
        "AdjustmentType": "CHANGE_IN_CAPACITY",
        "ScalingAdjustment": 1,
        "CoolDown": 300
      }
    },
    "Trigger": {
      "CloudWatchAlarmDefinition": {
        "ComparisonOperator": "LESS_THAN",
        "EvaluationPeriods": 1,
        "MetricName": "YARNMemoryAvailablePercentage",
        "Namespace": "AWS/ElasticMapReduce",
        "Period": 300,
        "Statistic": "AVERAGE",
        "Threshold": 15.0,
        "Unit": "PERCENT"
      }
    }
  }
]
}
EOF

}

