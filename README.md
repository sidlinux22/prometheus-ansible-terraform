# Project Details
> This is sample project to build automatic stack to run simple blogging application on the cloud using Wordpress.We are using AWS cloud as target infra.This project use Prometheus and cAdvisor to collect metrics and  Grafana for  visualisation.The entire project is intended to be a container based system

Here are the specs used in this project:

* OS: Ubuntu Server
* App Server: Nginx
* Configuration Management: Ansible
* IAAS : Terraform
* Cloud provider : AWS
* Docker
* Wordpress
* DB mysql
* Prometheus
* cAdvisor
* Grafana


### Prerequisites
You should have aws account with  the following resource created:
* AWS access/secret keys
* VPC and subnet
* Key pair 


### Usage :

1) Clone git project to workstation
2) Run the bootstrap ```deploy.sh``` script to setup enviroment 

Script usage:

```sh  deploy.sh -e <environment> -a <app name>  -c <count_instance> -t <instance_type> -u <user_name>```

> deploy.sh will assign AWS variable at the time of execution.
Assign value :
+ AWS Access/Secret key : Use to access you AWS resource
+ key-pair :  will use by ansible for remote login

<em>Note : you can change default value of deploy.sh script from terraform var file here terraform/aws/variables.tf <em>


Once deploy.sh script is successfully completed it will automatically create following stack
* Nginx server running wordpress app 
App Endpoint : ```http://<Host IP Address>```

* Grafana and Prometheus
To collect project matrix and to visualise with Grafana
+ Grafana Dashboard : ```http://<Host IP Address>:3000```
username - admin password - foobar (Password is stored in the config.monitoring env file)
+ Prometheus alerts: ```http://<Host IP Address>:9090/alerts ```
+ Alert Manager:  ```http://<Host IP Address>:9093```

## Post Configuration
 Create  Prometheus Datasource in order to connect Grafana to Prometheus 
* Click the `Grafana` Menu at the top left corner (looks like a fireball)
* Click `Data Sources`
* Click the green button `Add Data Source`.

<img src="https://github.com/sidlinux22/prometheus-ansible-terraform/blob/master/images/conf_grafana.png" width="400" heighth="400">

## Install Dashboard
Dashboard template which is available on [Grafana Docker Dashboard](https://grafana.net/dashboards/179). Simply download the dashboard and select from the Grafana menu -> Dashboards -> Import

Grafana Dashboard :
[Grafana Dashboard]


<img src="https://github.com/sidlinux22/prometheus-ansible-terraform/blob/master/images/System_Monitoring.png" width="400" heighth="600">




<img src="https://github.com/sidlinux22/prometheus-ansible-terraform/blob/master/images/docker-dashboard_rev5.png" width="400" heighth="400">

```
dashboards/Grafana_Dashboard.json
dashboards/System_Monitoring.json
dashboards/docker-dashboard_rev5.json
```

## Tested 
This project is tested with following spec:
```
docker==2.5.1
docker-compose==1.16.1
docker-pycreds==0.2.1
dockerpty==0.4.1
docker-compose version 1.16.1
Docker version 17.05.0-ce, build 89658be
Python 2.7.6
ansible 2.4.0.0
Terraform v0.10.7
```

## Troubleshooting
* pip freeze ( To verify the install package version )
* Run ansible command line to verify and provide private key used to verify any authentication issue 
* More details on [docker_service] (http://docs.ansible.com/ansible/latest/docker_service_module.html)
* Terraform Module to run ansible playbooks [terraform-null-ansible](https://github.com/cloudposse/terraform-null-ansible)