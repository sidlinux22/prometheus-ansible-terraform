#!/bin/sh 

# count_instance=1
# instance_type="t2.micro"

usage() { echo "deploy.sh -e <environment> -a <app name>  -c <count_instance> -t <instance_type> -u <user_name>" 1>&2; read -p "Press any key to exit " answer; exit 1; }

shift $((OPTIND-1))
while getopts "e:a:c:t:u" o; do
    case "$o" in
        e)
            env_name=$OPTARG
            ;;
        a)
            app_name=$OPTARG
            ;;
        c)
            count_instance=$OPTARG
            ;;
        t)
            instance_type=$OPTARG
            ;;
        u)
            user_name=$OPTARG
            ;;
            
        *)
            usage
            ;;
    esac
done

if [ -z "${app_name}" ] || [ -z "${env_name}" ]; then
    echo "Please provide require param"
    usage
fi
echo "Deployment details:
################################
APPNAME $app_name 
ENV $env_name 
SERVER COUNT ${count_instance:-1} 
INSTANCE TYPE ${instance_type:-t2.micro}
USER_NAME ${user_name:-deploy}"


# PROVIDER
#  AWD ENV VARIABLE
#
shift $((OPTIND-1))
read -p "AWS_ACCESS_KEY_ID: " AWS_ACCESS_KEY_ID
stty -echo 
read -p "AWS_SECRET_ACCESS_KEY: " AWS_SECRET_ACCESS_KEY; echo 
stty echo
export TF_VAR_AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export TF_VAR_AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

#
## Terraform
#
export TF_VAR_USER_NAME=${user_name:-deploy}
export TF_VAR_NUM_SERVERS=${count_instance:-1}
export TF_VAR_SERVER_SIZE=${instance_type:-t2.micro}
export TF_VAR_ENV_NAME=${env_name:-dev}
export TF_VAR_APP_NAME=$app_name
env | grep TF_VAR
if [[ $PATH =~ .*{`pwd`}.* ]] ; 
    then echo "Path exists, not updating" ; 
    else export PATH=$PATH:`pwd`; 
fi


read -p "Are you sure you wish to continue?[Y]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cd terraform/aws
    terraform apply .
else 
   echo "Exiting .."
   exit 2
fi
