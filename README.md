The main components of terraform scirpt are mentioned below:
1. provider.tf : holds information about region and authentication prpfile to be used.
2. backend.tf: holds information about verion of aws provider and source of it.external backend can be added here if required, sample config has been mentioned.
3. init.sh : This is a bash script which will get executed in userdata section during instance boot. It will install all required packages and run docker conatiners.
4. main.tf : This file has code to create ec2 instance using amazon linux AMI, along Applicaiton and database conatiners running in it.
5. variables.tf and terraform.tfvars : These files contains defined variables information which can vary environment to environment.

Prerequisites to run teraform script to launch instance with docker installed in it along with app and db contaainers running:
1. aws cli should be configured on system from which terraform script is being invoked.
2. Change profile name in backend.tf to whatever configured during aws cli configuration.
3. Create a public and private key which will be used to access ec2 instance through ssh and change public key location in terraform.tfvars file.
4. Change vpc id in terraform.tfvars
4. Change myip variable value to your machine ip from where traffic should be allowed on port 3000 and 22.
5. Script is expecting a subnet inside your vpc with tag "Purpose" = "public" and subnet id is not hard