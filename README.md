# Notes App with Nodejs and Mysql

Notes App is a Multi Page Application using Nodejs and Mysql. The purpose of this web application is just to be an example for beginners.

# Project Deployment Guide

## AWSCLI

1. Install AWS CLI.
2. Configure IAM credentials with EC2, RDS, VPC, and CloudFormation Full Access permissions.
3. Create and download Secret key and Access key as a .csv file.
4. Run `aws configure` to configure the user.

## Terraform

1. Clone or download the repo locally using Visual Studio Code or Git Bash.
2. Modify values in `Infra.tf`, `vars.tf`, and `terraform.tfvars` based on your AWS configuration.
3. Run the following commands:
    ```
    terraform init
    terraform plan
    terraform apply
    ```
4. To remove resources, use `terraform destroy`.

## Database Configuration

1. Configure the database details in `src/config.js`.
2. Modify `database/db.sql` with the desired database name.
3. Connect to the BuildEC2 machine and install the MySQL client.
4. Run `mysql -u username -p databasename -h DBendpoint` to connect to the MySQL database.
5. Paste the code from `db.sql` to create the database and tables.

## Dockerize

1. Create a Dockerfile for the Node.js application.
2. Use `package.json` to install dependencies and copy files.
3. Build and test the Node.js application:
    ```
    docker build -t project .
    docker run -d -p 80:4000 project
    ```

## BuildEC2

1. Connect to the BuildEC2 machine.
2. Check if Java, Jenkins, and Docker are installed.
3. Open Jenkins at `http://publicip:8080`.
4. Configure Jenkins, create a new pipeline project, and choose the pipeline script from SCM.
5. Configure Docker username and password as environment variables.
6. Create credentials for DeployEC2 connection.
7. Install SSH and SSH-Agent plugins for connecting to DeployEC2.
8. Trigger the build; the pipeline script will execute.

## DeployEC2

1. Docker installation is done via Terraform.
2. Once Jenkins build is successful, the application will run on DeployEC2.
3. Check running containers using `docker ps`.
4. Access the application using `http://publicip:80`.

## Monitoring

1. Install Prometheus and Grafana from [GitHub repo](https://github.com/Vennilavan12/prometheus-grafana-setup.git).
2. Run provided shell scripts.
3. Create a `daemon.json` file for collecting Docker metrics.
4. Add jobs to `node_exporter` and `docker` in `prometheus.yml`.
5. Restart Prometheus and Docker servers.
    ```
    sudo service Prometheus restart
    sudo service docker restart
    ```
6. Access monitoring servers:
    - Node_exporter: http://publicip:9100
    - Prometheus: http://publicip:9090
    - Grafana: http://publicip:3000
    - Docker logs: http://publicip:9323/metrics
7. Create Grafana dashboard, add connections, and import Docker templates.

