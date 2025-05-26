1. Create an SSH key-pair via AWS Console, within EC2. Input the name of the key pair, use RSA as type, select .pem as format.
2. Launching an instance
   - Include a name on your instance
   - Choose Amazon Linux 2023 as AMI
   - Select x86 arch
   - Select t2.micro as instance type
   - Supply the key pair name
   - Use default VPC
   - Select subnet available from default VPC
   - Set 'auto-assign public IP' to "Enable"
   - Create security group named my_first_instance_sg
   - Allow ssh
   - Set source type to "anywhere"
   - Set 30GiB gp3 for storage
   - Once instance is in running state, output a message
