command_not_found_handle () {
    # Check if there is a container image with that name
    if ! docker inspect --format '{{ .Author }}' "$1" >&/dev/null
    then
	echo "$0: $1: command not found"
	return
    fi
    # Check that it's really the name of the image, not a prefix
    if docker inspect --format '{{ .Id }}' "$1" | grep -q "^$1"
    then
	echo "$0: $1: command not found"
	return
    fi
    # If we are somewhere within our home, go there.
    if echo $PWD | grep -q ^/home
    then
	WORKDIR=$PWD
    else
	WORKDIR=/home
    fi
    docker run -it -P -u $(whoami) -w "$WORKDIR" \
	$(env | cut -d= -f1 | awk '{print "-e", $1}') \
	--device /dev/kvm:/dev/kvm \
	-v /dev/snd:/dev/snd \
	-v /etc/passwd:/etc/passwd:ro \
	-v /etc/group:/etc/group:ro \
	-v /etc/localtime:/etc/localtime:ro \
	-v /home:/home \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	"$@"
}
