# Запуск приложений по рабочим столам
# Закрыть все программы
# Запустить сервер
# 	Перезапустить сервер
# Проверить статус cpufreq
# 	Изменение статуса cpufreq
# Рисунок при старте скрипта

function killApps ()
{
	local apps=(
	"telegram"
	"discord"
	"chromium"
	"musikcube"
	"obsidian"
	)

	for item in "${apps[@]}"; do
		pkill -f "$item"
	done
}

launchApps ()
{
	local apps=(
	"discord"
	"telegram-desktop"
	"alacritty -e musikcube"
	"obsidian"
	)

	for item in "${apps[@]}"; do
		i3-msg "exec ${item}"
	done
}

moveToSpaces ()
{
	i3-msg '[class="obsidian"] move to workspace 1'
	i3-msg '[class="TelegramDesktop"] move to workspace 9'
	i3-msg '[class="discord"] move to workspace 9'
	i3-msg '[class="chromium"] move to workspace 2'
}

startMenu ()
{
	PS3="!>"
	options=(
	"launch"
	"kill"
	"server"
	"quit"
	)
	select opt in "${options[@]}"
	do
		case $opt in
			"kill")
				killApps ""
			;;
			"quit")
				break
			;;
			*)
				echo "nothing to do"
		esac
	done
}

main ()
{
	echo "Battery: $(acpi | grep -oE '[0-9]+%')"
	startMenu
	return 0
}

main "$@"
