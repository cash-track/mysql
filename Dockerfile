# Trying to use latest build to check if "Packets out of order" bug is fixed.
#
# See: https://bugs.php.net/bug.php?id=81335&edit=1
FROM mysql:8.0.26

RUN ln -snf /usr/share/zoneinfo/UTC /etc/localtime && echo UTC > /etc/timezone

RUN chown -R mysql:root /var/lib/mysql/

ADD my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]

EXPOSE 3306