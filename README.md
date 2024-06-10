# ChronoForge
ChronoForge automates todo app deployment with Terraform, Docker, Kubernetes, Jenkins, and Ansible. Monitor with Prometheus &amp; Grafana. Simplify task management in DevOps workflows.

![image](https://github.com/Gbeengah/ChronoForge/assets/97206259/aaa6ee05-5eaa-435a-a9f7-a7d46831210a)


       
# Project Overview:



The goal of this project is to automate the deployment of a todo web application built with Node.js and Express.js using a CI/CD pipeline. The pipeline will leverage Terraform for infrastructure provisioning, Docker for containerization, Kubernetes for orchestration, AWS as the cloud provider, Jenkins for continuous integration, Ansible for configuration management, and Prometheus with Grafana for monitoring and alerting. The source code will be managed using Git/GitHub.


## Project Infrastructure:



### AWS Infrastructure:



Use Terraform to provision AWS resources such as EC2 instances for Jenkins, Kubernetes cluster using EKS, VPC, subnets, security groups, and IAM roles.



### Jenkins Server:



Jenkins will be installed on an EC2 instance.
Configure Jenkins to listen for changes in the GitHub repository.



### Kubernetes Cluster (EKS):


Provision a Kubernetes cluster on AWS EKS using Terraform.
Set up nodes for the Kubernetes cluster to deploy containers.



### Docker Images:

Containerize the Node.js application using Docker.
Push the Docker image to Docker Hub 



### CI/CD Pipeline:



Configure Jenkins to trigger builds upon code commits to the GitHub repository.
Jenkins will build the Docker image, run tests, and push the image to a container registry.
Use Ansible to manage configuration and deployment tasks.



### Kubernetes Deployment:



Define Kubernetes manifests (Deployment, Service, Ingress, etc.) for deploying the Node.js application.
Automate deployment using Kubernetes CLI (kubectl) or Kubernetes API.




### Monitoring and Alerting:



Set up Prometheus for monitoring Kubernetes cluster metrics and application metrics.
Grafana will be used to visualize metrics and set up dashboards for monitoring.
Configure alerts in Prometheus for critical metrics.
CI/CD Pipeline Steps:



### Code Commit:

Developer commits changes to the GitHub repository.



### Continuous Integration (Jenkins):

Jenkins detects the code changes.
Jenkins pulls the latest code from GitHub.
Run unit tests and linting.
Build Docker image.


### Continuous Deployment:



Push Docker image to Docker Hub or AWS ECR.
Deploy the new image to Kubernetes cluster.
Use Ansible for configuration management tasks if needed.


### Monitoring and Alerting:



Prometheus collects metrics from Kubernetes and the application.
Grafana provides visualization and monitoring dashboards.
Set up alerts for critical metrics.



## Conclusion:



This DevOps project provides an end-to-end automation pipeline for deploying a todo web application on AWS infrastructure using modern DevOps tools and practices. It ensures rapid and reliable delivery of software updates while maintaining high availability and observability of the application.

This project will help you understand and implement the core concepts of DevOps, such as CI/CD, infrastructure as code, containerization, orchestration, and monitoring, using a real-world application.
