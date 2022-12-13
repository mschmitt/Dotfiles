all:
	git pull
	git submodule update --init --recursive --remote
	yes | ./deploy.sh
	-make -C Private
