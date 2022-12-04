## EMR setting default
aws_region = "ap-northeast-2"
emr_name = "emr-terraform-test-1"
emr_release_label = "emr-6.5.0"
emr_applications = ["Spark", "Hadoop"]

emr_subnet_id = "subnet-af74f4d4"
emr_role_name = "EMR_DefaultRole"
ec2_instance_role_name = "EMR_EC2_DefaultRole"
emr_autoscaling_policy_role_name = "EMR_AutoScaling_DefaultRole"
ec2_instance_key_pair_name = "emr-data-pipeline-1"

## master instance configure
master_instance_group_instance_type = "r5.xlarge"
master_instance_group_instance_count = 1
master_instance_group_ebs_size = 30
master_instance_group_ebs_type = "gp2"
master_instance_group_ebs_volumes_per_instance = 1


## core instance configure
core_instance_group_instance_type = "r5.xlarge"
core_instance_group_instance_count = 1
core_instance_group_ebs_size = 30
core_instance_group_ebs_type = "gp2"
core_instance_group_ebs_volumes_per_instance = 1


## task instance configure
create_task_instance_group = true
task_instance_group_instance_type = "r5.xlarge"
task_instance_group_instance_count = 1
task_instance_group_instance_min_count = 1
task_instance_group_instance_max_count = 3

### task instance auto scaling
task_scale_out_yarn_memory_available_percentage = 15
task_scale_out_container_pending_ratio = 0.75
task_scale_in_yarn_memory_available_percentage = 75


