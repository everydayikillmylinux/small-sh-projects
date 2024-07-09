path=(
	"$HOME/.config/alacritty/alacritty.toml"
	"$HOME/.config/nvim/init.lua"
	"/etc/pacman.conf"
	"$HOME/.bashrc"
	"/etc/X11/xorg.conf"
	"$HOME/.config/i3/config"
)

cd "$HOME/.dots"

for ((i=0; i<${#path[@]};i++)); do
	cp "${path[i]}" ~/.dots
done

git add .
git -C ~/.dots status
