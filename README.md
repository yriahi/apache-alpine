This repo aims at building a Docker image with a running Apache on Alpine Linux. Refer to the `Dockerfile` for the steps taken to build this image.


### Build
Clone this repo and make the desired changes to the `Dockerfile` ; then run this command to build an image called "my-apache2-alpine" from with the root of this cloned repo:
`cd apache2-alpine && docker build -t my-apache2-alpine .`


### Run
For this demo, the container will read a basic ` index.html` from within this cloned repo.

- Map current working directory for a simple html to docroot in the container:
  `docker run -d --rm -p 80:80 -v "$(pwd)":/var/www/localhost/htdocs my-apache-alpine`
- Using `-v` or `--volume`
  `docker run -d --rm -p 80:80 --volume /path/to/app/docroot,/app/docroot my-apache-alpine`
- Using `bindfs` to map a folder from host to container:
  `docker run -d --rm -p 80:80 --mount type=bind,source=/path/to/app/docroot,destination=/app/docroot my-apache-alpine`
- The flags used are as follow:
  `-d` run in detached mode
  `--rm` deletes container once exited
  `--name` specifies a name to the container
  `-p` port e.g. with  `-p 8080:80`, we'll type `http://localhost:8080` to get to the running Apache.
  `-v` attaches a volume
  _my-apache2-alpine_ is the name of locally built Docker image that we are using to run this container.
