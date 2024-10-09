# Automated ML Workflow with Terraform, Docker, AWS EC2 and MSFT Phi3 GenAI

This project automates the deployment of an ML model using Terraform and interacts with the deployed model using command line.

##  Project Structure

This directory contains the Terraform code for provisioning infrastructure resources on AWS. It utilizes separate configurations:
1) setup: Creates an S3 bucket and DynamoDB table for storing Terraform state and managing state locking.
2) deploy: Deploys an EC2 instance specifically for running Terraform commands and another instance for hosting the ML model.
3) ONNX Runtime GenAI Script: This script defines the interaction with the deployed ML model using the ONNX Runtime GenAI library. It takes user input, generates responses using the model, and displays the results.

### Prerequisites
1) An AWS account with appropriate IAM permissions for Terraform and EC2 access.
2) An existing ML model converted to ONNX format and stored in the cpu_and_mobile/cpu-int4-rtn-block-32-acc-level-4 folder.
3) An SSH key pair configured for access to the EC2 instance hosting the ML model.

### Setup
1) Configure your AWS credentials (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and optionally AWS_SESSION_TOKEN) as environment variables.
2) Ensure your SSH key pair is available and referenced by the your-key.pem path in the Terraform configuration.
3) Update the ami values in the Terraform configuration for both instances based on your chosen AMI images for your region.

### Running the Project & Deployment:
1) Open a terminal and navigate to the project directory.
2) Run docker-compose up -d to start the Docker container for Terraform. This container mounts the setup and deploy directories for Terraform execution.
3) Choose between deploying the setup or deploy configuration:
4) For setup: Run docker exec -it terraform terraform apply -auto-approve to provision the S3 bucket.
4) For deployment: Set the desired Terraform workspace (e.g., dev, prod) using export TF_WORKSPACE=<workspace_name>. Then, run docker exec -it terraform terraform apply -auto-approve to deploy the EC2 instances.

### Interaction:
Once deployment is complete, the script can be run to interact with the deployed ML model.
1) Copy the public ip of the ec2 instance
2) SSH into the public ip
3) Run python onnx_genai_script.py

The script will prompt for user input, generate a response using the deployed model, and display the output.

