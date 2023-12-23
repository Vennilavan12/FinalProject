# Notes App with Nodejs and Mysql

Notes App is a Multi Page Application using Nodejs and Mysql. The purpose of this web application is just to be an example for beginners.

![](docs/screenshot2.png)
![](docs/screenshot.png)
Installation Part:
1.	AWSCLI
2.	Terraform
3.	Node [required only for run code locally]

AWSCLI:
	Once cli installation completes configure IAM credentials for give permission for Terraform.
	Permissions are EC2, RDS, VPC and Cloud Formation Full Access.
	Create and download Secret key and Access key as .csv file.

aws configure

	Use this command to configure our user.

Terraform:
	Clone or download the repo locally and use Visual studio code or Git bash for creating resources in aws for this Project.
	The Infra.tf file all resource configuration and vars.tf, terraform.tfvars contains variables and values.
	Change the values accordingly with your aws configuration (e.g: ami, keyname, region). 
terraform init
terrafom plan
terraform apply

	Once your all works done do terraform destroy to remove the resources.

Database Configuration:
	Configure the database values as your own values.
	Go to src/config.js change your database details (name, host, user, password, port).
	Next go to database/db.sql file and change the database name and copy the code.
	Go to buildEC2 machine and install mysql client.

mysql -u username –p databasename –h DBendpoint

	Use this command to connect our mysql database and paste the code of db.sql and run it.
	It will create database and tables for your website.

Dockerize:
	First go through the code and create a Dockerfile for nodejs application.
	Use package.json file to install dependencies and copy all files to run the code using npm run.
	Once Dockerfile created build and test the nodejs application.

docker build –t project .
docker run –d –p 80:4000 project


BuildEC2:
	Connect BuildEC2 machine its already have done all installation using terraform code.
	Check java, Jenkins and Docker installed on this machines.
	Copy your Public ip and add port 8080 to open Jenkins.

http://publicip:8080
 
	Configure Jenkins and create a new project as pipeline.
	Jenkinsfile in the github already contains pipeline steps to build the application.
	Configure Jenkins pipeline project and choose pipeline script from scm.
	Also configure docker username and password as environment variables in manage Jenkins.
	Create credential that is used to connect our DeployEC2 machine that will asks username and private key of your DeployEC2 instance.
	Paste Private key and give id and save Credentials.
	Install ssh and ssh-agent plugin for connecting our DeployEc2.
	Go to system and search ssh-add menu and fill name, Hostname, IP and test the connection.
	Once all the Process completes trigger the build the pipeline script will start executing.

DeployEC2:
	On DeployEC2 machine docker installation is already done via Terraform.
	Once Jenkins build success it will run your application on DeployEC2 machine.

docker ps

	This commands shows the running container of our application and check the output using public ip at port 80.

http://publicip:80

Monitoring:
	In this Project i can monitor the docker container using Prometheus and grafana.
	Install Prometheus and Grafana using provided github repo url.

https://github.com/Vennilavan12/prometheus-grafana-setup.git

	This repo contains three .sh files so you change as root user and run those scripts.
	It will install node exporter, Prometheus and grafana.
	Create a daemon.json file for collecting docker metrics and add jobs node_exporter and docker in Prometheus.yml file.
	Once configurations done restart those servers.

sudo service Prometheus restart
sudo service docker restart

	Check the monitoring servers using public ip

Node_exporter: http://publicip:9100
Prometheus: http://publicip:9090
Grafana: http://publicip:3000
Docker logs: http://publicip:9323/metrics

	Create grafana dashboard and add connections.
	Choose connection as Prometheus and test the connection.
	Once it completes import docker templates our build your dashboard using queries.

