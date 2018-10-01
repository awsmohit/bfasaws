# AWS
#export AWS_PROFILE=bfas  		# Comment out to use default profile
export AWS_REGION=us-west-2


#configbucketforgluewest2      
#bfas-sandbox-s3-config-bucket
#bfas-sandox-configbucketforgluewest2
export SWAMPFOLDERPATH=External/enterprisedatapersonsedited
#External/ShelterStatistics/ShelterLuv/Reports/Instance=LA/Year=2018/Month=09/Day=26/Hour=15/ShelterluvReportEnterpriseDataPersonsEditedLA-1537977500169.json
#shelterluvla
export LAKEFOLDERPATH=people

# EMAIL FOR ALERTS
export EMAIL=awsmohit@amazon.com

# Project Tags
export PROJECT="bfasmm"	
export ENVIRONMENT="sandbox"
export LOCATION="Oregon"
export OWNER="IT"
export CONTACT="IT@bfas.org"

# GLUE DATABASE CONFIG
export GLUEDATALAKEDB=glue-database-lake
export GLUEDATASWAMPDB=glue-database-swamp

export S3SWAMPBUCKET=s3-swamp
export S3LAKEBUCKET=s3-lake
export S3ETLBUCKET=s3-etl

# Stack Names
export S3STACK=S3
export GLUESTACK=glue
export BFASDATASTACK=bfasdatastack 
export GLUESWAMPCRAWLER=glue-crawler-swamp
export GLUELAKECRAWLER=glue-crawler-lake
export GLUEETLPEOPLE=glue-etl-people
