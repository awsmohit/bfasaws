set -e

function check_env {
  [ -z "$STACKNAME" ] && { echo "ERR: STACKNAME not defined"; abort=1; }
  [ -z "$TEMPLATE" ] && { echo "ERR: TEMPLATE not defined"; abort=1; }
  [ -z "$ENVIRONMENT" ] && { echo "ERR: ENVIRONMENT not defined"; abort=1; }
  [ -z "$PROJECT" ] && { echo "ERR: PROJECT not defined"; abort=1; }
  [ -z "$abort" ] || { echo "aborting.."; exit 1; }
}

function stack_status {
  echo -n "${STACKNAME}: "; aws cloudformation describe-stacks --stack-name $STACKNAME | jq .Stacks[0].StackStatus
}

function stack_create {
  check_env
  aws cloudformation create-stack \
    --stack-name $STACKNAME \
    --template-body file://$TEMPLATE \
    --tags Key=Environment,Value="$ENVIRONMENT" \
           Key=Project,Value="$PROJECT" \
           Key=Location,Value="$LOCATION" \
           Key=Owner,Value="$OWNER" \
           Key=Contact,Value="$CONTACT" \
    --capabilities CAPABILITY_IAM \
    $EXTRAARGS
  echo "Wait for stack create: $STACKNAME"
  aws cloudformation wait stack-create-complete \
    --stack-name $STACKNAME
  stack_status
}

function stack_update {
  check_env
  aws cloudformation update-stack \
    --stack-name $STACKNAME \
    --template-body file://$TEMPLATE \
    --tags Key=Environment,Value=$ENVIRONMENT Key=Project,Value=$PROJECT \
    --capabilities CAPABILITY_IAM \
    $EXTRAARGS
  echo "Wait for stack update: $STACKNAME"
  aws cloudformation wait stack-update-complete \
    --stack-name $STACKNAME
  stack_status
}

function stack_delete {
  check_env
  aws cloudformation delete-stack \
    --stack-name $STACKNAME 
  echo "Wait for stack delete: $STACKNAME"
  aws cloudformation wait stack-delete-complete \
    --stack-name $STACKNAME | true
  echo "Done"
}

function stack_outputs {
  if [ ! -z "$1" ]; then 
    STACKNAME=$1
  fi
  check_env
  aws cloudformation describe-stacks --stack-name $STACKNAME | jq '.Stacks[0].Outputs[] | "\(.OutputKey) \(.OutputValue)"' | sed -e 's/"//g'
}

function stack_action {
  case "$1" in
  -c)  stack_create
      ;;
  -u)  stack_update
      ;;
  -d)  stack_delete
      ;;
  -s)  stack_status
      ;;
  *)
      echo Usage: $0 [-c] [-u] [-d] [-s]
      ;;
  esac
}
