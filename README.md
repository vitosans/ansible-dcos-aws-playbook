# ansible-dcos
*Forked* from the awesome [ansible-dcos-aws-playbook](https://github.com/olatheander/ansible-dcos-aws-playbook) These are changes that I needed to get the project working on my version of Ansible 2.2.1.0 and I also output the ec2.py dynamic to a static file so I could deploy on baremetal with minor changes to the playbooks. I hope this points someone in the right direction as it did me. 

Ansible Playbooks for setting up DC/OS on AWS. Default configuration of 3 masters, 5 slaves, and 2 public slaves behind an AWS elastic load-balancer on a 3 subnet VPC, 2 public subnets on different availiability zones and 1 private subnet.

To try it out do:

1. Configure `~/.boto` as described in [Boto Config](http://boto.readthedocs.org/en/latest/boto_config_tut.html):

   ```
   [Credentials]
   aws_access_key_id = <your_access_key_here>
   aws_secret_access_key = <your_secret_key_here>
   ```
2. Add your `*.pem` file to the `ssh-agent`:

   ```
   $ ssh-agent bash 
   $ ssh-add ~/.ssh/<amazon key file> 
   ```
3. Define the environment variables (see below). The AWS variables are mandatory.
4. Run the playbook as `ansible-playbook -i ec2.py main.yml` to set up the EC2 instances, VPC, subnets, ELB etc.
5. [boto3](https://pypi.python.org/pypi/boto3) must be installed.
6. Run the playbook as `ansible-playbook -i ec2.py provision_cluster.yml` to provision the instances with DC/OS nodes.

## Environment variables
The following environment varibles can be configured for Ansible lookup

### AWS
* EC2_TARGET_OS: the target OS for the cluster nodes and can be any of [`Ubuntu` (default), `CentOS`]. Defines the AMI and SSH user for the provisioning.
* EC2_TARGET_OS_VERSION: the version of the target e.g. `Xenial` for Ubuntu, `7` for CentOS.
* AWS_EC2_KEY_PAIR: the name of the key pair to use when provisioning the cluster (EC2 instances etc.).
* AWS_EC2_LB_CERT: the `arn` resource for the AWS ELB certificate.
* AWS_S3_ELB_LOGS_BUCKET_NAME: the name of the S3 bucket where to store the ELB logs.
* EC2_REGION: the region you wish to use.
* EC2_INSTANCE_SIZE_JUMP: the instance size to use for the jumpserver.
* EC2_INSTANCE_SIZE_MASTER: the instance size for the master.
* EC2_INSTANCE_SIZE_SLAVE: the instance size for the slaves.
* EC2_INSTANCE_SIZE_SLAVE_PUBLIC: the instance size for the public slaves. 
* EC2_INSTANCE_SIZE_BOOTSTRAP: the instance size for the bootstrap.
* AWS_S3_ELB_LOGS_PREFIX: the prefix for the ELB Log bucket.

### DC/OS
* DCOS_CONTROLLER_INSTALL_DEMOS: `true` - install demo(s) (default), `false` - skip demo installation.

#### Demos
* DCOS_CONTROLLER_INSTALL_DEMO_SD_AND_LB_NGINX: `true` - install demo setting up Nginx as described in [Service discovery and load balancing with DCOS and marathon-lb: Part 1](https://mesosphere.com/blog/2015/12/04/dcos-marathon-lb/).
* DCOS_CONTROLLER_INSTALL_DOCKERCLOUD_HELLO_WORLD: `true` - install [Dockercloud hello-world](https://github.com/docker/dockercloud-hello-world) demo.


#### Gotchas

* The ELB 2 S3 Bucket can be a bit challenging, I have provided the JSON needed to apply the correct permissions. This was mostly a problem from not reading the docs :) 

### TODO

- [x] ip-detect.sh - remove hard coded eth0 as Amazon instances can have weird names
- [x] Make instance sizes adjustable
- [x] Make region switching a varible
- [ ] Use Ansible for ELB SSL 
- [ ] Use Ansible for ELB -> S3 log bucket
- [ ] Add instance count to enviorment per-role
- [ ] Rework VPC to use CloudFormation templates from DCOS