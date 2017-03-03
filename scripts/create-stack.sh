#!/bin/bash

# creates a stack in AWS via CloudFromation

STACKNAME=${1:-Weapon-X-Search}
DOMAIN_NAME=${2:-weapon-x}
INSTANCE_TYPE=${3:-t2.small.elasticsearch}
VOLUME_SIZE=${4:-10}
PROJECTNAME=${5:-Weapon-X}
ENVIRONMENT=${6:-development}
CREATOR=${7:-CloudFormation}
PURPOSE=${8:-Testing}
TEMPLATELOCATION=${8:-file://$(pwd)/elasticsearch.yml}

VALIDATE="aws cloudformation validate-template --template-body $TEMPLATELOCATION"
echo $VALIDATE
$VALIDATE

CREATE="aws cloudformation create-stack --stack-name $STACKNAME \
                                        --disable-rollback \
                                        --template-body $TEMPLATELOCATION \
                                        --capabilities CAPABILITY_NAMED_IAM \
                                        --parameters ParameterKey=Project,ParameterValue=$PROJECTNAME \
                                                     ParameterKey=Environment,ParameterValue=$ENVIRONMENT \
                                                     ParameterKey=Creator,ParameterValue=$CREATOR \
                                                     ParameterKey=VolumeSize,ParameterValue=$VOLUME_SIZE \
                                                     ParameterKey=InstanceType,ParameterValue=$INSTANCE_TYPE \
                                                     ParameterKey=DomainName,ParameterValue=$DOMAIN_NAME \
                                        --tags Key=Project,Value=$PROJECTNAME \
                                               Key=Purpose,Value=$PURPOSE \
                                               Key=Environment,Value=$ENVIRONMENT \
                                               Key=Creator,Value=$CREATOR"
echo $CREATE
$CREATE
