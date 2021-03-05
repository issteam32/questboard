# questboard
ISS Project - QuestBoard

This project will be deployed using kubernetes. Developing and maintaining multiple docker image on local is a pain, so, we need to prepare the local development environment as follow:

What we need:

* kubectl
* minikube
* docker & docker-compose
* skaffold

The steps mentioned below is specifically for questboard project.
 
Docker & Docker-compose & Kubernetes
-----------------------
Linux installation (Ubuntu), guide from https://docs.docker.com/engine/install/
```
#uninstall old version

sudo apt-get remove docker docker-engine docker.io containerd runc

#setup repository

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg
	
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io
 
 
#verify it is installed
sudo docker run hello-world

```
post installation steps: avoid using sudo on docker command
```
sudo groupadd docker


sudo usermod -aG docker $USER

newgrp docker 
 
# verify it is working
docker run hello-world

```

Install Kubernetes
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"


#validate the binary
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

echo "$(<kubectl.sha256) kubectl" | sha256sum --check

#if valid output is: 
kubectl: OK

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#verify it is installed
kubectl version --client

```

Install Minikube
```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube start

#you should be seeing minikube spawning a docker container, more guide refer to https://minikube.sigs.k8s.io/docs/start/
```

Install Skaffold
```
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \

sudo install skaffold /usr/local/bin/

#verify it is installed
skaffold --help

```


--------------------------------------------------------------
Windows Installation, guide from https://docs.docker.com/docker-for-windows/install/

1. Download Docker Desktop from docker hub, https://hub.docker.com/editions/community/docker-ce-desktop-windows/
2. post installation steps, configure resources on docker desktop. Open Docker Desktop > Settings > Resources > File Sharing , then configure the path that docker will be using it for "volumes".
3. Go to Kubernetes tab, enable Kubernetes.
4. Apply & Restart

Install Minikube
1. Download from https://storage.googleapis.com/minikube/releases/latest/minikube-installer.exe
2. open powershell or cmd then run ```minikube start```

Install Skaffold
1. Download from https://storage.googleapis.com/skaffold/releases/latest/skaffold-windows-amd64.exe
2. open powershell or cmd then run ```skaffold --help```

--------------------------------------------------------------
Mac Installation, guide from https://docs.docker.com/docker-for-mac/install/
1. Download Docker Desktop from docker hub, https://hub.docker.com/editions/community/docker-ce-desktop-mac/
2. post installation steps, configure resources on docker desktop. Open Docker Desktop > Settings > Resources > File Sharing , then configure the path that docker will be using it for "volumes".
3. Go to Kubernetes tab, enable Kubernetes.
4. Apply & Restart

Install Minikube
1. brew install minikube or ``` curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 &&
sudo install minikube-darwin-amd64 /usr/local/bin/minikube ```
2. Open terminal and ```minikube start```


Install Skaffold
1. Download from https://storage.googleapis.com/skaffold/releases/latest/skaffold-darwin-amd64 or ```brew install skaffold```
2. Open terminal and ``` skaffold --help ```

----------------------------------------------------------------

Overview of Local Development Environment
--------------------------
![alt text](https://github.com/issteam32/questboard/blob/master/sample-folder-structure.png?raw=true)
sample project file structure
```
project-folder/
|___services-1-folder/
|	|___src/
|	    Dockerfile # docker production build
|	    Dockerfile.dev # docker development build
|	    service-1.pod.yaml
|	    service-1.service.yaml
|___services-2-folder/
|	|___src/
|	    Dockerfile 
|	    Dockerfile.dev
|	    service-2.pod.yaml
|	    service-2.service.yaml
|___.travis.yml # define the travis build pipeline
|___.service.account.json.enc # used for deployment
|___docker-compose.yaml #spin up development database
|___skaffold.yaml 
|___.gitignore
```

---------------------------------------------------------------
