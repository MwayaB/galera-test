FROM centos:7

# Install necessary packages
RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y rsync firewalld

# Create the Galera repository file
RUN echo -e "[galera]\n\
name = Galera\n\
baseurl = https://releases.galeracluster.com/galera-4/centos/7/x86_64/\n\
gpgkey = https://releases.galeracluster.com/GPG-KEY-galeracluster.com\n\
gpgcheck = 1\n\
\n\
[mysql-wsrep]\n\
name = MySQL-wsrep\n\
baseurl = https://releases.galeracluster.com/mysql-wsrep-8.0/centos/7/x86_64/\n\
gpgkey = https://releases.galeracluster.com/GPG-KEY-galeracluster.com\n\
gpgcheck = 1" > /etc/yum.repos.d/galera.repo

# Install MySQL wsrep and Galera
RUN yum install -y galera-4 mysql-wsrep-8.0

# Default command to run mysqld
ENTRYPOINT ["mysqld"]