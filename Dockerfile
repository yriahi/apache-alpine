FROM alpine:latest
MAINTAINER Youssef Riahi <y.riahi@gmail.com>

# update & upgrade os
RUN apk update && apk upgrade

# install apache + utils
RUN apk add --no-cache apache2 apache2-utils

# where "httpd.pid" file will be located
RUN mkdir -p /run/apache2/

# custom "/app" path instead of out of the box "/var/www/localhost/htdocs"
RUN mkdir -p /app/docroot

# move apache logs to "/app" folder since we changed server root
RUN mkdir -p /app/logs

# symlink modules from ""/usr/lib" to the new "/app" folder
RUN ln -s /usr/lib/apache2 /app/modules

# fix permission on new /app path
RUN chown -R apache:www-data /app/docroot

# fix "Could not reliably determine the server's fully qualified domain name”
RUN sed -i 's/^#ServerName.*/ServerName myapache2/' /etc/apache2/httpd.conf

# ServerRoot path
RUN sed -i 's#^ServerRoot .*#ServerRoot /app#g' /etc/apache2/httpd.conf

# DocumentRoot path
RUN sed -i 's#^DocumentRoot ".*#DocumentRoot "/app/docroot"#g' /etc/apache2/httpd.conf

# allow .htaccess files
RUN sed -i 's#AllowOverride [Nn]one#AllowOverride All#' /etc/apache2/httpd.conf

# Directory path
RUN sed -i 's#Directory "/var/www/localhost/htdocs.*#Directory "/app/docroot" >#g' /etc/apache2/httpd.conf

# change the group of the actual "apache" user running "httpd"
RUN sed -i -e 's/Group apache/Group www-data/g' /etc/apache2/httpd.conf

# mod_rewrite
RUN sed -i 's/^#LoadModule rewrite_module/LoadModule rewrite_module/' /etc/apache2/httpd.conf

#LoadModule expires_module
RUN sed -i 's/^#LoadModule expires_module/LoadModule expires_module/' /etc/apache2/httpd.conf

# cleanup
RUN rm -rf /var/cache/apk/*

# listen on
EXPOSE 80 443

# run apache
CMD ["httpd", "-D", "FOREGROUND"]
