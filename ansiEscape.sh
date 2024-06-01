textStyles=(
"bold" # 1
"dim/faint" # 2
"italic" # 3
"underline" # 4
"blinking" # 5
"inverse" # 7
"invisible" # 8
"strikethrough" # 9
)

colors=(
"Black" # 30
"Red" # 31
"Green" # 32
"Yellow" # 33
"Blue" # 34
"Magenta" # 35
"Cyan" # 36
"White" # 37
)

brightColors=(
"Bright Black" # 90
"Bright Red" # 91
"Bright Green" # 92
"Bright Yellow" # 93
"Bright Blue" # 94
"Bright Magenta" # 95
"Bright Cyan" # 96
"Bright White" # 97
)

main()
{
	i=0
	j=1
	while (( i != 8 )); do
		(( j == 6 )) && j=7
		printf "|%b%-13s" "\e[${j}m" "${textStyles[$i]}"
		printf "\e[0m"
		printf "%s\n" "|\e[${j}m|"
		(( j++ ))
		(( i++ ))
	done

	printf "\n"

	i=0
	j=30
	while (( i != 8 )); do
		printf "|%b%-7s" "\e[${j}m" "${colors[$i]}"
		printf "\e[0m"
		printf "%s\n" "|\e[${j}m|"
		(( j++ ))
		(( i++ ))
	done

	printf "\n"

	i=0
	j=90
	while (( i != 8 )); do
		printf "|%b%-14s" "\e[${j}m" "${brightColors[$i]}"
		printf "\e[0m"
		printf "|%s|\n" "\e[${j}m"
		((i++))
		((j++))
	done

	printf "\n"

	i=0
	j=1
	while (( i != 256 )); do
		printf "|\e[38;5;%dm%3s" "$i" "$i"
		printf "\e[0m"
		(( j % 5 == 0 )) && printf "|\n"
		(( i++ ))
		(( j++ ))
	done
	printf "\n"
}

main "$@"
