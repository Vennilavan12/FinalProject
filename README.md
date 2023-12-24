# Notes App with Node.js and MySQL

**Notes App** is a Multi Page Application using Node.js and MySQL. This web application serves as an example for beginners.

## Project Deployment Guide

### Overview

#### Stage 1: Dockerization and GitHub Repository
- Dockerize the Node.js application and move the files into a GitHub repository.

#### Stage 2: Terraform Resource Provisioning
- Use Terraform to provision resources required for running the project.

#### Stage 3: AWSCLI for AWS Cloud Connection
- Utilize AWSCLI to connect to the AWS Cloud and create resources using Terraform.

#### Stage 4: Database Setup
- Set up Amazon RDS MySQL to host the data for the project.

#### Stage 5: Two-server Configuration
- Utilize two servers for distinct purposes:
  - One for building and pushing the project.
  - Another for deploying the application.

#### Stage 6: Continuous Integration with Jenkins
- Implement continuous integration using Jenkins:
  - Build, push, and deploy with a Jenkins pipeline.

#### Stage 7: Monitoring with Prometheus and Grafana
- Monitor Docker containers using Prometheus and Grafana:
  - Configure Prometheus to collect metrics.
  - Utilize Grafana for visualization.

![Screenshot](https://github.com/Vennilavan12/FinalProject/assets/77039703/fdcadfb1-52f9-4561-b5cc-9d3d867363af)

# Check this [link](https://github.com/Vennilavan12/FinalProject/tree/main/docs) for all output screenshots and configurations in the readme.md.

## AWSCLI

1. Install AWS CLI.
2. Configure IAM credentials with EC2, RDS, VPC, and CloudFormation Full Access permissions.
3. Create and download Secret key and Access key as a .csv file.
4. Run `aws configure` to configure the user.
   
https://github.com/Vennilavan12/FinalProject/tree/main/docs/AWSCLI >> Check this link for AWSCLI configuration and outputs.

## Terraform

1. Clone or download the repo locally using Visual Studio Code or Git Bash.
2. Modify values in `Infra.tf`, `vars.tf`, and `terraform.tfvars` based on your AWS configuration.
3. Run the following commands:
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```
4. To remove resources, use `terraform destroy`.

https://github.com/Vennilavan12/FinalProject/tree/main/docs/Terraform >> Check this link for Terraform Configuration and outputs.

## Database Configuration

1. Configure the database details in `src/config.js`.
2. Modify `database/db.sql` with the desired database name.
3. Connect to the BuildEC2 machine and install the MySQL client.
4. Run `mysql -u username -p -h DBendpoint` to connect to the MySQL database.
5. Paste the code from `db.sql` to create the database and tables.

https://github.com/Vennilavan12/FinalProject/tree/main/docs/RDS >> Check this link for Database Configuration and outputs.

## Dockerize

1. Create a Dockerfile for the Node.js application.
2. Use `package.json` to install dependencies and copy files.
3. Build and test the Node.js application:
    ```bash
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

https://github.com/Vennilavan12/FinalProject/tree/main/docs/Jenkins >> check this link for Jenkins Configuration and outputs.

## DeployEC2

1. Docker installation is done via Terraform.
2. Once Jenkins build is successful, the application will run on DeployEC2.
3. Check running containers using `docker ps`.
4. Access the application using `http://publicip:80`.

https://github.com/Vennilavan12/FinalProject/tree/main/docs/AWS >> Check this link for AWS Deployment and security group screenshot and outputs.

## Monitoring

1. Install Prometheus and Grafana from [GitHub repo](https://github.com/Vennilavan12/prometheus-grafana-setup.git).
2. Run provided shell scripts.
3. Create a `daemon.json` file for collecting Docker metrics.
4. Add jobs to `node_exporter` and `docker` in `prometheus.yml`.
5. Restart Prometheus and Docker servers:
    ```bash
    sudo service Prometheus restart
    sudo service docker restart
    ```
6. Access monitoring servers:
    - Node_exporter: http://publicip:9100
    - Prometheus: http://publicip:9090
    - Grafana: http://publicip:3000
    - Docker logs: http://publicip:9323/metrics
7. Create Grafana dashboard, add connections, and import Docker templates.

https://github.com/Vennilavan12/FinalProject/tree/main/docs/Monitoring >> Check this link for Monitoring configuration and outputs.
   
## Final Output
<img width="959" alt="Screenshot 2023-12-23 123623" src="https://github.com/Vennilavan12/FinalProject/assets/77039703/20426e32-6fb1-42e5-8b73-0f65a7248a08">
<img width="960" alt="Screenshot 2023-12-23 123638" src="https://github.com/Vennilavan12/FinalProject/assets/77039703/efd92503-b69f-4539-9563-962711742cf3">
<img width="959" alt="Screenshot 2023-12-23 123714" src="https://github.com/Vennilavan12/FinalProject/assets/77039703/d4573600-3130-4e1d-8ad9-0ab241fb92a7">
<img width="960" alt="Screenshot 2023-12-23 123751" src="https://github.com/Vennilavan12/FinalProject/assets/77039703/e8061b26-c950-45f4-86e8-3d226650bced">

## Challenges

### 1. Node.js and DB Connection Issue

If you encounter issues with the Node.js and database connection, ensure the following:

- Check the configurations in `src/config.js` for accurate database details.
- Verify that the MySQL server is accessible from the Node.js application.

### 2. Terraform Userdata Installation Issue

In case the Terraform userdata doesn't install correctly, consider the following:

- Check the userdata script in your Terraform configuration.
- Review the system logs on the affected instances for any error messages during userdata execution.
- Manually run the installation commands to identify and resolve any issues.

### 3. Grafana Metrics Retrieval Issue

If Grafana is not fetching metrics correctly, troubleshoot using these steps:

- Verify that Prometheus and Grafana are correctly configured and running.
- Check the Prometheus configuration (`prometheus.yml`) to ensure jobs like `node_exporter` and `docker` are correctly defined.
- Restart Prometheus and Grafana servers and monitor logs for any errors.
