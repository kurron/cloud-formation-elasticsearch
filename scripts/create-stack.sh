#!/bin/bash

# creates a stack in AWS via CloudFromation

STACKNAME=${1:-Weapon-X-Search}
DOMAINNAME=${2:-weapon-x}
PROJECTNAME=${3:-Weapon-X}
ENVIRONMENT=${4:-development}
CREATOR=${5:-CloudFormation}
PURPOSE=${6:-Testing}
TEMPLATELOCATION=${7:-file://$(pwd)/elasticsearch.yml}

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
                                                     ParameterKey=DomainName,ParameterValue=$DOMAINNAME \
                                        --tags Key=Project,Value=$PROJECTNAME \
                                               Key=Purpose,Value=$PURPOSE \
                                               Key=Environment,Value=$ENVIRONMENT \
                                               Key=Creator,Value=$CREATOR"
echo $CREATE
$CREATE
