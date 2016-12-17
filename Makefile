IMAGE_NAME=debian/echo

run:
	bundle exec rackup

docker: permissions
	docker build -t ${IMAGE_NAME} .

permissions:
	# ensure that executables are executable
	chmod +x config/docker/my_init.d/*
	chmod -R +x config/docker/runit/*
	chmod +x config/docker/bin/*
