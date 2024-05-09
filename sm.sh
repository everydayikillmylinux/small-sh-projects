function killApps ()
{
	local apps=(
	"telegram"
	"discord"
	"chromium"
	"musikcube"
	"obsidian"
	"steam"
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
	"obsidian"
	)

	for item in "${apps[@]}"; do
		i3-msg "exec ${item}" > /dev/null
	done
}

moveToSpaces ()
{
	i3-msg '[class="obsidian"] move to workspace 1'
	i3-msg '[class="TelegramDesktop"] move to workspace 9'
	i3-msg '[class="discord"] move to workspace 9'
	i3-msg '[class="chromium"] move to workspace 2'
}

checkCpuFreqMode ()
{
	local arg=$1

	if [[ "$(cpufreqctl.auto-cpufreq --governor | grep performance)" =~ "performance" ]]; then
		[[ $arg -eq 1 ]] && echo "mode: performance"
		return 1
	elif [[ "$(cpufreqctl.auto-cpufreq --governor | grep powersave)" =~ "powersave" ]]; then
		[[ $arg -eq 1 ]] && echo "mode: powersave"
		return 0
	fi
}

switchCpuFreqMode ()
{
	checkCpuFreqMode
	local result="$?"

	if [[ $result -eq 1 ]]; then
		sudo auto-cpufreq --force=powersave > /dev/null
	elif [[ $result -eq 0 ]]; then
		sudo auto-cpufreq --force=performance > /dev/null
	fi
}

updateCheck ()
{
	if checkupdates > /dev/null; then
		echo "there are some new updates"
	else
		echo "nothing in updates"
	fi
}

startMenu ()
{
	PS3="!>"
	options=(
	"launch"
	"switch cpu mode"
	"kill"
	"check updates"
	"quit"
	)

	select opt in "${options[@]}"
	do
		case $opt in
			"launch")
				launchApps ""
			;;
			"kill")
				killApps ""
			;;
			"switch cpu mode")
				switchCpuFreqMode ""
			;;
			"check updates")
				updateCheck ""
			;;
			"quit")
				clear
				break
			;;
			*)
				echo nothing to do
		esac
	done
}

main ()
{
	echo ---
	echo "battery: $(acpi | grep -oE '[0-9]+%')"
	checkCpuFreqMode 1
	echo ---
	startMenu

	return 0
}

main "$@"
