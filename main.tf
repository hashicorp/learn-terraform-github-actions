terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  cloud {
    organization = "nowfloats"

    workspaces {
      name = "hg-poc-pipeline"
    }
  }
}
provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "hg_vpc_main" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name"        = "${var.environment}-vpc"
    "Environment" = "${var.environment}"
  }
}

resource "aws_internet_gateway" "hg_ig_main" {
  vpc_id = aws_vpc.hg_vpc_main.id
  tags = {
    "Name"        = "${var.environment}-igw"
    "Environment" = "${var.environment}"
  }
}

resource "aws_eip" "hg_nat_eip" {
  vpc = true
  #? count = length(var.private_subnets)
  depends_on = [
    aws_internet_gateway.hg_ig_main
  ]
}

# resource "aws_nat_gateway" "hg_natgateway_main" {
#   subnet_id     = element(aws_subnet.hg_subnet_public.*.id, 0)
#   allocation_id = aws_eip.hg_nat_eip.id
#   depends_on = [
#     aws_internet_gateway.hg_ig_main
#   ]
#   tags = {
#     "Name"        = "NAT"
#     "Environment" = var.environment
#   }
#   # count = length(var.private_subnets)
# }

resource "aws_subnet" "hg_subnet_private" {
  vpc_id     = aws_vpc.hg_vpc_main.id
  cidr_block = element(var.private_subnets, 0)
  # availability_zone = element(var.availability_zones, count.index)
}

resource "aws_subnet" "hg_subnet_public" {
  vpc_id                  = aws_vpc.hg_vpc_main.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true
}

resource "aws_route_table" "hg_rt_public" {
  vpc_id = aws_vpc.hg_vpc_main.id
}

resource "aws_route" "hg_route_public" {
  route_table_id         = aws_route_table.hg_rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.hg_ig_main.id
}

resource "aws_route_table_association" "hg_rta_public" {
  route_table_id = aws_route_table.hg_rt_public.id
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.hg_subnet_public.*.id, count.index)
}

resource "aws_route_table" "hg_rt_private" {
  vpc_id = aws_vpc.hg_vpc_main.id
  count  = length(var.private_subnets)
}

# resource "aws_route" "hg_route_private" {
#   count                  = length(compact(var.private_subnets))
#   route_table_id         = element(aws_route_table.hg_rt_private.*.id, count.index)
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = element(aws_nat_gateway.hg_natgateway_main.*.id, count.index)
# }

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.hg_subnet_private.*.id, count.index)
  route_table_id = element(aws_route_table.hg_rt_private.*.id, count.index)
}

resource "aws_security_group" "hg_sg_alb" {
  vpc_id = aws_vpc.hg_vpc_main.id
  name   = "${var.name}-sg-alb-${var.environment}"

  ingress {
    protocol         = "tcp"
    from_port        = 80
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    protocol         = "tcp"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_security_group" "hg_sg_ecstasks" {
  name   = "${var.name}-sg-task-${var.environment}"
  vpc_id = aws_vpc.hg_vpc_main.id

  ingress {
    protocol         = "tcp"
    from_port        = var.container_port
    to_port          = var.container_port
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_ecr_repository" "hgecrpoc" {
  name                 = "${var.name}-${var.environment}"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.hgecrpoc.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "keep last 10 images"
      action = {
        type = "expire"
      }
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
    }]
  })
}

resource "aws_ecs_cluster" "main" {
  name = "${var.name}-cluster-${var.environment}"
}

resource "aws_ecs_task_definition" "main" {
  network_mode             = "awsvpc"
  family                   = "hg_ecs_task_poc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode([
    {
      name        = var.container_name
      image       = "748469861505.dkr.ecr.ap-south-1.amazonaws.com/hg"
      essential   = true
      environment = [{ "name" : "VARNAME", "value" : "VARVAL" }]
      portMappings = [{
        protocol      = "tcp"
        containerPort = var.container_port
        hostPort      = var.container_port
      }]
    }
  ])
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.name}-ecsTaskExecutionRole"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.name}-ecsTaskRole"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}