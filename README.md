# DevOps Terraform and Ansible Project

For this project, I used Terraform and Ansible to setup and deploy an application to a target node within an ec2 on aws. I will be using my local machine as a master node. Terraform will be used to set up IaC and Ansible will be used to set up through automation everything within that infrastructure. The diagram below gives a quick overlook of how everything is going to be set up within this project.


<img width="1249" alt="Screenshot 2024-07-16 at 9 43 12 AM" src="https://github.com/user-attachments/assets/d35e321e-08e2-46df-8924-a04ddd72a4f7">

Using terraform, we will create a few resources which include: EC2 instance, Security Group, S3 Bucket, and Dynamodb.

First thing to do is using ```gh repo create``` on the terminal to create a repo. Configure how you want it, and you can set the .gitignore template to 'Terraform'. Make sure clone the repo to your local machine.

Next, ```cd <your-repo-name> ``` and initialize terraform within your repo using ```terraform init```.

For the following steps, a few files have to be made which can be done using ```touch``` or ```vim```: main.tf, providers.tf, variables.tf. Configure these files.

After the terraform files have been configured, run ```terraform plan``` and ```terraform validate``` just to make sure everything is set up correctly.

Run ```terraform apply``` to create the infrastructure.


The next following steps are for Ansible configuration. First things first, run ```brew install ansible``` to install it. After, run ```mkdir ansible-dir``` to make a directory within the repo that will hold the playbooks. Go into that directory and make an inventory file and an updates.yml file for start. Inventory just helps with pointing paths and specifying a user. Updates.yml will run system updates within the target server. Configure these files.

```ansible-playbook updates.yml -i inventory``` can be used to run the updates.yml playbook.

Next, create a packages.yml file which will install python and other needed packages. Run that file using ```ansible-playbook packages.yml -i inventory```.

Create a ```vim gunicorn_config.py.j2``` file and ```vim code.yml``` file. gunicorn_config.py.j2 just sets the workers and bind for gunicorn, code.yml will actually pull in the code for the application into the target server. 

Configure these files using the application repo.

Create a .env file, as well as a service file for gunicorn.

Create a ```vim copyenv.yml``` file and a ```vim gunicorn-setup.yml``` file. The first file will help configure variables in the server and the latter will help set up gunicorn within that server.

Last file to create is ```vim install-mysql.yml``` for the database if needed.





