all:
	git pull
	git submodule update --init --recursive
	yes | ./deploy.sh
	make -C Private
