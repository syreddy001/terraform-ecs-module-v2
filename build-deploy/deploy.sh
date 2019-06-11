#!/bin/sh -e

#Usage: docker_container_version [create|update]

# register task-definition
repository_url=`echo $1 | sed 's~http[s]*://~~g'`
image_name=$2

eval $(aws ecr get-login --no-include-email --region us-east-1)

# If the image doesn't exists, we build it and push it to the repository.
# if [[ "$(docker images -q 160692692427.dkr.ecr.us-east-1.amazonaws.com/hello-world 2> /dev/null)" == "" ]]; then
#   docker build -t ${image_name} .
#   docker tag ${image_name}:latest ${repository_url}:latest
#   docker push ${repository_url}:latest
# fi


sed <td-nginx.template -e "s,@VERSION@,$1,">TASKDEF.json

aws ecs register-task-definition --cli-input-json file://TASKDEF.json > REGISTERED_TASKDEF.json
TASKDEFINITION_ARN=$( < REGISTERED_TASKDEF.json jq .taskDefinition.taskDefinitionArn |sed -e 's/[""]//g')
echo $TASKDEFINITION_ARN
# create or update service
sed s,@@TASKDEFINITION_ARN@@,$TASKDEFINITION_ARN, <service-$2-nginx.json >SERVICEDEF.json
aws ecs $2-service --cli-input-json file://SERVICEDEF.json | tee SERVICE.json
