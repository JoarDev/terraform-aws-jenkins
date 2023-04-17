# Deploy Jenkins Server on AWS EC2 using Terrafom
The following AWS resources will be created:
- EC2 instance
- Security Group
- AWS key pair

The `jenkins-install.sh` file will install the jenkins server on EC2 launch
It will also create a local private key needed for the ssh connection to the EC2

## Outputs after doing `terraform apply`
- `jenkins-server-url`: http url to connect to the jenkins server on port 8080
- `ec2-ssh-command`: command to ssh into the EC2 instance using the local private key

## Considerations
- The EC2 `instance_type` and AMI qualify under the AWS free tier.  
- The EC2 instance will be provisioned in the default VPC
- All of the resources will be created in the `us-west-2` region


<a href="https://www.linkedin.com/in/joardev/">
  <img src="https://img.shields.io/badge/Linkedin-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" />
</a>