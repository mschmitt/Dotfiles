# Check for updates

function dotfiles_clone_timestamp() {
	git -C ~/Dotfiles --no-pager log -1 --format="%at"
}

function dotfiles_upstream_timestamp() {
	local commitdate
	commitdate="$(curl --connect-timeout 1 --silent --fail https://api.github.com/repos/mschmitt/Dotfiles/commits/master | jq -r '.commit.author.date')"
	date --date="${commitdate:-1970-01-01T00:00:00Z}" +%s
}

if [[ $(dotfiles_upstream_timestamp) -gt $(dotfiles_clone_timestamp) ]]
then
	printf "Dotfiles update available\n"
fi
