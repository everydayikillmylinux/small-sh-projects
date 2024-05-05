: "
Archiving
zip: zip <archive_name>.zip <file1> <fileN>
tgz: tar -zcvf <archive_name>.tgz <file1> <fileN>
rar: rar a <archive>.rar <file1> <fileN>

Extracting
zip: unzip <name>.zip
tgz: tar -xzvf <name>.tar.gz
rar: unrar x <archive>.rar

dm - dataManagement

TODO:
	- Проверка наличия пакетов архивации или разархивации
	- Проектирование под возможность добавления новых архиваторов и экстракторов
	- about с мнемонической штукой, авторством и картинкой
"

help=""

function paramsHandler ()
{
	command=$1

	case $command in
		--help|-h) echo -e "$help"
		;;
	esac
}

function interactiveMode ()
{
	:
}

function unarchive ()
{

#Extracting
#zip: unzip <name>.zip
#tgz: tar -xzvf <name>.tar.gz
#rar: unrar x <archive>.rar

	archives=( "$@" )
	[[ $# == 0 ]] && archives=( * )
	for item in "${archives[@]}"; do
		[[ "${item}" =~ ".zip" ]] && unzip "$item" > /dev/null && echo zip!
		[[ "${item}" =~ ".tgz" ]] && tar -xzvf "$item" > /dev/null && echo tgz!
		[[ "${item}" =~ ".rar" ]] && unrar x "$item" > /dev/null && echo rar!
	done
}


main ()
{
	paramsHandler "$@"
	unarchive "$@"
	
	return 0
}

main "$@"
