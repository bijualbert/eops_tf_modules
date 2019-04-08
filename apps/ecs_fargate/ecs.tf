resource "aws_ecs_cluster" "main" {
  name = "${var.cluster_name}"
}

resource "aws_ecs_task_definition" "main_task" {
  family                   = "${var.cluster_name}Task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.cpu_value}"
  memory                   = "${var.memory_value}"
  network_mode             = "awsvpc"
  container_definitions    = "${var.container_definition}"
  execution_role_arn       = "${var.execution_role_arn}"
  task_role_arn            = "${var.task_role_arn}"
}

output "task_definition_arn" {
  value = "${aws_ecs_task_definition.main_task.arn}"
}

output "ecs_fargate_cluster_arn" {
  value = "${aws_ecs_cluster.main.arn}"
}
