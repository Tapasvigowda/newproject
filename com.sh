#!/bin/bash
 
echo "Updating system packages..."
sudo yum update -y

echo "Installing Maven..."
sudo yum install maven -y
 
echo "Installing Docker..."
sudo yum install docker -y
 
echo "Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker
 
echo "Adding Jenkins repository..."
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/rpm-stable/jenkins.repo
 
echo "Importing Jenkins GPG key..."
sudo rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2026.key
 
echo "Upgrading packages..."
sudo yum upgrade -y
 
echo "Installing Java 21 Amazon Corretto..."
sudo yum install java-21-amazon-corretto -y
 
echo "Installing Jenkins..."
sudo yum install jenkins -y
 
echo "Enabling Jenkins service..."
sudo systemctl enable jenkins
 
echo "Adding Jenkins user to Docker group..."
sudo usermod -aG docker jenkins
 
echo "Starting Jenkins service..."
sudo systemctl start jenkins
 
echo "Checking Jenkins service status..."
sudo systemctl status jenkins --no-pager
 
echo ""
echo "========================================="
echo "Jenkins Initial Admin Password:"
echo "========================================="
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo ""
