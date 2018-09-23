set -e

# check for file ($1) and print message ($2) if file does not exist
function s3_exists {
  aws s3 ls $1 > /dev/null || {
    echo "ERR: missing: $1"
    echo "$2"
    error=1 
    }
}
