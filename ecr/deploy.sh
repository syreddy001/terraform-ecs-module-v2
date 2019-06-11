#!/bin/sh -e

#Usage: docker_container_version [create|update]

# register task-definition
repository_url=`echo $1 | sed 's~http[s]*://~~g'`
image_name=$2

eval $(aws ecr get-login --no-include-email --region us-east-1)

# If the image doesn't exists, we build it and push it to the repository.
# if [[ "$(docker images -q 160692692427.dkr.ecr.us-east-1.amazonaws.com/hello-world 2> /dev/null)" == "" ]]; then
  docker build -t ecs-helloworld .
  docker tag ecs-helloworld:latest ${repository_url}:latest
  docker push ${repository_url}:latest
# fi
