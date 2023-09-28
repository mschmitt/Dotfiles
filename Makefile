all:
	git pull
	ansible-playbook play-dotfiles.yml
	-make -C Private
