#! /bin/bash -e
for f in include/*;do source $f; done

SWAMPBUCKET=$PROJECT-$ENVIRONMENT-$S3SWAMPBUCKET
LAKEBUCKET=$PROJECT-$ENVIRONMENT-$S3LAKEBUCKET
ETLBUCKET=$PROJECT-$ENVIRONMENT-$S3ETLBUCKET
SWAMPDB=$PROJECT-$ENVIRONMENT-$GLUEDATASWAMPDB
LAKEDB=$PROJECT-$ENVIRONMENT-$GLUEDATALAKEDB
SWAMPCRAWLER=$PROJECT-$ENVIRONMENT-$GLUESWAMPCRAWLER
LAKECRAWLER=$PROJECT-$ENVIRONMENT-$GLUELAKECRAWLER
ETLNAME=$PROJECT-$ENVIRONMENT-$GLUEETLPEOPLE
echo $ETLBUCKET

# Upload glue ETL jobs to S3
if [ $1 != "-d" -a $1 != "-s" ]; then
  aws s3 cp ../src/glueetl s3://$ETLBUCKET/glueetl/ --recursive
fi

# Upload Python libraries to S3
if [ $1 != "-d" -a $1 != "-s" ]; then
  aws s3 cp ../src/libs s3://$ETLBUCKET/libs/ --recursive
fi

STACKNAME=$GLUESTACK

TEMPLATE="../templates/glue.yaml"
DATASWAMPBUCKET=$(stack_outputs "$S3STACK" | awk '/DataSwampBucketName/ {print $2}')
DATALAKEBUCKET=$(stack_outputs "$S3STACK" | awk '/DataLakeBucketName/ {print $2}')
EXTRAARGS="--parameters \
  ParameterKey=BFASDATASTACK,ParameterValue=$BFASDATASTACK$ENVIRONMENT\
  ParameterKey=ETLBUCKET,ParameterValue=$ETLBUCKET\
  ParameterKey=DATASWAMPBUCKET,ParameterValue=$SWAMPBUCKET\
  ParameterKey=DATALAKEBUCKET,ParameterValue=$LAKEBUCKET\
  ParameterKey=GLUEDATALAKEDB,ParameterValue=$LAKEDB\
  ParameterKey=GLUEDATASWAMPDB,ParameterValue=$SWAMPDB\
  ParameterKey=SWAMPCRAWLER,ParameterValue=$SWAMPCRAWLER\
  ParameterKey=LAKECRAWLER,ParameterValue=$LAKECRAWLER\
  ParameterKey=ETLNAME,ParameterValue=$ETLNAME\
  ParameterKey=SWAMPFOLDERPATH,ParameterValue=$SWAMPFOLDERPATH\
  ParameterKey=LAKEFOLDERPATH,ParameterValue=$LAKEFOLDERPATH\
  "
stack_action $1



