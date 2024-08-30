[
  {
    "name": "${name}",
    "image": "${app_image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "networkMode": "${network_mode}",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/${name}",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${host_port}
      }
    ]
  }
]