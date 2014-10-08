# mumble-server
A docker container for Mumble Server configured with environment variables

    SUPW=superuserpassword
    ROOMS=general,gaming,music

All together:

    docker run -p 64738:64738/tcp -p 64738:64738/udp -e ROOMS="general,gaming" -e SUPW=1337 -t jhaals/mumble-server
