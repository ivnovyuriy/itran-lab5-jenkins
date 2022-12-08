# itran-lab5-jenkins

Prerequisites:

- AWS account
- Created S3 bucket to store your terraform output file 

1. Clone this repositiry from github to your local machine

```
git clone https://github.com/ivnovyuriy/itran-lab5-jenkins.git
```

2. Go to the /infrastra folder, and change environment details and variables on yours, then:

First, go to backend.tf file and change the name of your previously created bucket

```
terraform init
terraform plan
terraform apply -auto-approve
```
After 5-7 minutes webserver instance will deploy and you could reach your webserver by th following IP

And while webserver is provisioning let's configure Jenkins server

3. Setting Up Jenkins

![Jenkins](https://github.com/ivnovyuriy/itran-lab5-jenkins/blob/bca906fb397429d2fcc7ed654f8aa344d0871942/img/1.png)

SSH to you Jenkins server by the following command:

```
ssh -i your_key.pem ubuntu@your_server_ip
```

Go to you console and print following command:
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
![JenkinsFirstPass](https://github.com/ivnovyuriy/itran-lab5-jenkins/blob/bca906fb397429d2fcc7ed654f8aa344d0871942/img/2.png)

Copy the output password

Go to the web page and paste the generated password

http://your_server_ip:8080

4. Setting up out sample Project

    # create a virtual environment 
    ```bash
    cd Flask-Docker-App
    python3 -m venv venv
    ```

    # activate the environment
    ```source venv/bin/activate```

    # install the requirements
    ```
    pip install -r requirements.txt
    ```
    # run the application
    ```
    python app.py
    ```
# Test it on localhost
![Localhost test](https://github.com/ivnovyuriy/itran-lab5-jenkins/blob/bca906fb397429d2fcc7ed654f8aa344d0871942/img/3.png)

5. Install additional plugins for Jenkins

'''
Docker
GitHub
Ssh-agent
'''

6. Create new pipeline "Staging" & run the Job

![Localhost test](https://github.com/ivnovyuriy/itran-lab5-jenkins/blob/bca906fb397429d2fcc7ed654f8aa344d0871942/img/4.png)

It deploys on separate EC2 instance via ssh key

![Staging EC2 8000 port](https://github.com/ivnovyuriy/itran-lab5-jenkins/blob/bca906fb397429d2fcc7ed654f8aa344d0871942/img/5.png)

7. Create new pipeline "Production" & run the Job

![Localhost test](https://github.com/ivnovyuriy/itran-lab5-jenkins/blob/bca906fb397429d2fcc7ed654f8aa344d0871942/img/6.png)

It deploys on separate EC2 instance via ssh key

![Staging EC2 8080 port](https://github.com/ivnovyuriy/itran-lab5-jenkins/blob/bca906fb397429d2fcc7ed654f8aa344d0871942/img/7.png)