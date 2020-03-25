# pre env
```
apt install docker-ce
ssh-keygen
```
/root/.ssh/id_rsa.pub --> gitlab
deploy something to k8s

# gen makefile
```
vim Makefile
-----------------------------
INSTANCE_NAME=newton-jenkins
#IMAGE=jenkins/jenkins
IMAGE=iexception007/jenkins:centos
PORT1=88
PORT2=50000

.PHONY: run clean

run: clean
	mkdir -p /data/jenkins/data
	docker run -d --restart=always \
           --add-host kubernetes:172.16.24.151 \
           --add-host harbor.cloudminds.com:10.51.201.101 \
           -p ${PORT1}:8080 \
           -p ${PORT2}:50000 \
           -e JAVA_OPTS=-Duser.timezone=Asia/Shanghai \
           -v /root/.kube/config:/root/.kube/config \
           -v /root/.ssh:/root/.ssh \
           -v /data/jenkins/data:/var/jenkins_home \
           -v /var/run/docker.sock:/var/run/docker.sock \
           --name=${INSTANCE_NAME} ${IMAGE}
	docker exec -it newton-jenkins sh -c 'echo "PASSWORD" | docker login harbor.cloudminds.com -uadmin --password-stdin'
clean:
	-docker rm -f ${INSTANCE_NAME}
	#rm -rf /data/jenkins/data
```
# run
```
make run
```