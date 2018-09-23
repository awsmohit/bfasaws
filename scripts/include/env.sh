# AWS
#export AWS_PROFILE=bfas  		# Comment out to use default profile
export AWS_REGION=us-west-2

# S3 bucket used for configuration artifacts
export CONFIGBUCKET=configbucketforglue       # Bucket Name holding configuration artifacts
export FILEPATH=shelterluv

# EMAIL FOR ALERTS
export EMAIL=awsmohit@amazon.com

# Project Tags
export PROJECT="bfas"	
export ENVIRONMENT="Dev"
export LOCATION="Oregon"
export OWNER="IT"
export CONTACT="IT@bfas.org"

# GLUE DATABASE CONFIG
export GLUEDATABASENAME=datalakedb      # lowercase only

# Stack Names
export S3STACK=S3
export GLUESTACK=GLUE