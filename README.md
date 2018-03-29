Before starting docker container you have to build it. Run the command `docker build -t gerbrunn .` maybe you would need to add `sudo` before it.

After you have sucessfully created the container run it by `sh startcontainer.sh`. If your OS doesnt have `sudo` command, then run `docker run -ti -p 80:80 -p 21:21 gerbrunn`
