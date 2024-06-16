usagemsg="usage: ms <url> \"<trackname>\""
url=$1
name=$2

function getTrack ()
{
	yt-dlp -x --audio-format mp3 --audio-quality 0 -P ~/music \
		--no-keep-fragments -o "$name" $url
}

main ()
{
	if [[ -n "$url" && -n "$name" ]]; then
		getTrack
	else
		trap "clear && exit" SIGINT

		read -p "url: " url
		read -p "track: " name
		[[ -n "$url" && -n "$name" ]] && getTrack
	fi
	
	return 0
}

main "$@"
