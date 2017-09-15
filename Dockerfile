FROM centos:7

RUN yum groupinstall -y 'development tools'
RUN yum install -y wget

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y R

RUN yum install -y libxml2-devel
RUN yum install -y libcurl-devel.x86_64
RUN yum install -y openssl-devel
RUN su - -c "R -e \"install.packages(c('shiny','rmarkdown'), repos='http://cran.rstudio.com/')\""

RUN wget https://download3.rstudio.org/centos6.3/x86_64/shiny-server-1.5.2.837-rh6-x86_64.rpm
RUN yum install -y --nogpgcheck shiny-server-1.5.2.837-rh6-x86_64.rpm

EXPOSE 3838

# Installing R library dependencies
COPY mutation-demo/install.R /etc/shiny-server/





RUN R -e 'install.packages("devtools", repos="http://cran.rstudio.com/")'
RUN R -f /etc/shiny-server/install.R


COPY shiny-server.sh /usr/bin/shiny-server.sh

# running shiny server as shiny user requires write access to /var/lib/shiny-server
RUN chown -R shiny:shiny /var/lib/shiny-server

#VOLUME /data

RUN mkdir /srv/shiny-server/camcAPP; mkdir /srv/shiny-server/camcAPP/www

COPY mutation-demo/www/* /srv/shiny-server/mutation-demo/www/
COPY mutation-demo/*.R /srv/shiny-server/mutation-demo/

# modified shiny server configuration file
COPY shiny-server.conf /etc/shiny-server/

RUN chmod -R 777 /srv/shiny-server/mutation-demo/*
RUN chmod 777 /usr/bin/shiny-server.sh
CMD ["/usr/bin/shiny-server.sh"]