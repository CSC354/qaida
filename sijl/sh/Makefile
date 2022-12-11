container: ../Dockerfile
	./Makeimage.sh # build image if not
	chmod +x *
	docker network inspect debate-net >/dev/null 2>&1 || \
    docker network create --driver bridge debate-net
	./Makecontainer.sh
image: ../Dockerfile
	chmod +x *
	./Makeimage.sh

mssql: ../Dockerfile ../setup.sql
	./Makeimage.sh # build image if not
	chmod +x *
	docker network inspect debate-net >/dev/null 2>&1 || \
    docker network create --driver bridge debate-net
	./Makecontainer.sh
