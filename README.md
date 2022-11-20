**The main components of terraform scirpt are mentioned below:**
- `provider.tf`: Holds information about region and authentication profile to be used.
- `backend.tf`: Holds information about verion of aws provider and source of it. External backend can be added here if required, sample config has been mentioned.
- `init.sh`: This is a bash script which will execute in userdata section during instance boot. It will install all required packages and run docker conatiners.
- `main.tf`: This file has code to create ec2 instance using amazon linux AMI, along Applicaiton and database conatiners running in it.
- `variables.tf and terraform.tfvars`: These files contains defined variables information which can vary environment to environment.

**Prerequisites to run teraform script to launch instance with docker installed in it along with app and db contaainers running:**
- aws cli should be configured on system from which terraform script is being invoked.
- Change `profile name` in backend.tf to whatever configured during aws cli configuration.
- Create a public and private key which will be used to access ec2 instance through ssh and change public key location in `terraform.tfvars` file.
- Change `vpc id` in `terraform.tfvars`
- Change `myip variable` value to your machine ip from where traffic should be allowed on `port 3000 and 22`.
- Script is expecting a subnet inside your vpc with `tag "Purpose" = "public"`, make sure to add required tag.
