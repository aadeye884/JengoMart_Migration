# AMI From Docker Snapshot
resource "aws_ami_from_instance" "host_ami" {
  name               = var.ami-name
  source_instance_id = var.target-instance
}
# Creating Autoscaling
resource "aws_launch_configuration" "host_ASG_LC" {
  name            = var.launch-configname
  instance_type   = var.instance-type
  image_id        = aws_ami_from_instance.host_ami.id
  security_groups = var.sg_name3
  key_name        = var.key_name
  
}
resource "aws_autoscaling_group" "ASG" {
  name                      = var.asg-group-name
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 3
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.host_ASG_LC.name
  vpc_zone_identifier       = var.vpc-zone-identifier
}
resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.ASG.id
  lb_target_group_arn    = var.target-group-arn
}
resource "aws_autoscaling_policy" "host_ASG_POLICY" {
  name                   = var.asg-policy
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.ASG.name
}
