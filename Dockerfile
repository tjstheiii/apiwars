FROM tutum/lamp:latest
ENV apploc docker
ENV MYSQL_PASS apiwars
RUN rm -fr /app && git clone https://github.com/wbean1/apiwars.git /app
RUN sed -i s/'display_errors = Off'/'display_errors = On'/g /etc/php5/apache2/php.ini
EXPOSE 80 3306
CMD ["/run.sh"]
