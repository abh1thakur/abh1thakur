**The main components of terraform scirpt are mentioned below:**
- `provider.tf`: Holds information about region and authentication profile to be used.
- `backend.tf`: Holds information about verion of aws provider and source of it. External backend can be added here if required, sample config has been mentioned.
- `init.sh`: This is a bash script which will execute in userdata section during instance boot. It will install all required packages and run docker conatiners.
- `main.tf`: This file has code to create ec2 instance using amazon linux AMI, along Applicaiton and database conatiners running in it.
- `variables.tf and terraform.tfvars`: These files contains defined variables information which can vary environment to environment.

**Prerequisites to run teraform script to launch instance with docker installed in it along with app and db contaainers running:**
- aws cli should be configured on system from which terraform script is being invoked.
- Change below mentioned variables according to your environment in `terraform.tfvars` file.
~~~
$ cat terraform.tfvars 
vpc="<vpc-id>"
pub_key = "<public-key-location>"
myip = "<source ip for traffic whitelisting in security group>" // Get ipv4 public ip from https://whatismyipaddress.com/
instance_type="<instance-type>"                                 // e.g t2.micro
region = ""                                                     // Region to create resources in e.g.us-east-1
profile = ""                                                    // aws configure profile to use credentials from
~~~
