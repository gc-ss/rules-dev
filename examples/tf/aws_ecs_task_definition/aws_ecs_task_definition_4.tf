resource "aws_ecs_task_definition" "test" {
  family                = "test"
  container_definitions = <<TASK_DEFINITION
  [
  	{
  		"cpu": 10,
  		"command": ["sleep", "10"],
  		"entryPoint": ["/"],
  		"environment": [
  			{"name": "VARNAME", "value": "VARVAL"}
  		],
  		"essential": true,
  		"image": "jenkins",
  		"memory": 128,
  		"name": "jenkins",
  		"portMappings": [
  			{
  				"containerPort": 80,
  				"hostPort": 8080
  			}
  		],
          "resourceRequirements":[
              {
                  "type":"InferenceAccelerator",
                  "value":"device_1"
              }
          ]
  	}
  ]
  TASK_DEFINITION

  inference_accelerator {
    device_name = "device_1"
    device_type = "eia1.medium"
  }
}