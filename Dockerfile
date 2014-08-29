FROM tutum/lamp:latest
ENV apploc docker
RUN rm -fr /app && git clone https://github.com/wbean1/apiwars.git /app
EXPOSE 80 3306
CMD ["/run.sh"]
