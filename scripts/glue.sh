#! /bin/bash -e
for f in include/*;do source $f; done

# Upload glue ETL jobs to S3
if [ $1 != "-d" -a $1 != "-s" ]; then
  aws s3 cp ../src/glueetl s3://$CONFIGBUCKET/glueetl/ --recursive
fi

STACKNAME=$GLUESTACK
TEMPLATE="../templates/glue.yaml"
DATASWAMPBUCKET=$(stack_outputs "$S3STACK" | awk '/DataSwampBucketName/ {print $2}')
DATALAKEBUCKET=$(stack_outputs "$S3STACK" | awk '/DataLakeBucketName/ {print $2}')
EXTRAARGS="--parameters \
  ParameterKey=S3STACK,ParameterValue=$S3STACK\
  ParameterKey=CONFIGBUCKET,ParameterValue=$CONFIGBUCKET\
  ParameterKey=DATASWAMPBUCKET,ParameterValue=$DATASWAMPBUCKET\
  ParameterKey=DATALAKEBUCKET,ParameterValue=$DATALAKEBUCKET\
  ParameterKey=GLUEDATABASENAME,ParameterValue=$GLUEDATABASENAME\
  ParameterKey=FILEPATH,ParameterValue=$FILEPATH\
  "
stack_action $1



