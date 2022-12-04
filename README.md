# itran-lab5-jenkins

Prerequisites:

- AWS account
- Created S3 bucket to store your terraform output file 

1. Clone this repositiry from github to your local machine

```
git clone https://github.com/ivnovyuriy/itran-lab5-jenkins.git
```

2. Go to the /infra folder, and change environment details and variables on yours, then:

First, go to backend.tf file and change the name of your previously created bucket

```
terraform init
terraform plan
terraform apply -auto-approve
```
After 5-7 minutes webserver instance will deploy and you could reach your webserver by th following IP

And while webserver is provisioning let's configure Jenkins server

3. Setting Up Jenkins

IMAGE

SSH to you Jenkins server by the following command:

```
ssh -i your_key.pem ubuntu@your_server_ip
```

Go to you console and print following command:
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
IMAGE

Copy the output password

Go to the web page and paste the generated password

http://your_server_ip:8080

