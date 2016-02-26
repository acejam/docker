FROM ubuntu:14.04
MAINTAINER Joshua Noble "acejam@gmail.com"

#JENKINS & SYSTEM PACKAGES
RUN apt-get install -q -y wget curl && wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
RUN echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN apt-get update -q -y && apt-get clean && apt-get upgrade -q -y
RUN apt-get install -q -y openjdk-7-jre-headless git curl build-essential libssl-dev nodejs jenkins openssh-server && apt-get clean

# VOLUME ["/home/jenkins/.jenkins"]

# ADD run /usr/local/bin/run

#ESSENTIALS
# RUN apt-get install -y build-essential curl git-core vim sudo

#RUBY & RVM
RUN apt-get install -q -y libyaml-dev libreadline-dev libgdbm-dev libffi-dev libncurses-dev bison libxslt-dev libxml2-dev

RUN su jenkins -c "/bin/bash -l -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'"
RUN su jenkins -c "/bin/bash -l -c 'curl -sSL https://get.rvm.io | bash -s stable'"
RUN su jenkins -c "/bin/bash -l -c 'rvm autolibs 0'"
RUN su jenkins -c "/bin/bash -l -c 'rvm requirements'"
RUN su jenkins -c "/bin/bash -l -c 'rvm install 2.2.4'"
#NOKOGIRI prerequisites
# RUN DEBCONF_TERSE='yes' DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get -qq -y -u --force-yes install libxslt-dev libxml2-dev

#MYSQL server prerequisite
# Hack for initctl not being available in Ubuntu
# RUN dpkg-divert --local --rename --add /sbin/initctl
# RUN ln -s /bin/true /sbin/initctl

# EXPOSE 3306
# RUN DEBCONF_TERSE='yes' DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get -qq -y -u --force-yes install mysql-server libmysql-ruby

# Listen on all interfaces
# RUN sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf
# Allow root from non localhost IPs
# RUN /usr/sbin/mysqld & sleep 10s && mysql --host=127.0.0.1 --user=root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;"

#MYSQL client prerequisite
# RUN DEBCONF_TERSE='yes' DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get -qq -y -u --force-yes install libmysqlclient-dev

#MEMCACHE
# RUN apt-get install memcached -y

#REDIS
# RUN apt-get install redis-server -y

#RIAK
# RUN DEBCONF_TERSE='yes' DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get -qq -y -u --force-yes install libssl0.9.8 logrotate wget
# RUN wget http://s3.amazonaws.com/downloads.basho.com/riak/1.2/1.2.1/debian/6/riak_1.2.1-1_amd64.deb
# RUN dpkg -i riak_1.2.1-1_amd64.deb

#MONGO DB
# RUN apt-get install mongodb -y

#FIREFOX and X-SERVER
#RUN apt-get install firefox x-window-system gnome-core xvfb -y

#Copy SSH Key
# RUN apt-get update
# RUN apt-get install -y sudo openssh-server
# RUN ssh-keygen -t rsa -C "your_email@example.com"; ls -la
# ADD .ssh-keys /home/jenkins/.ssh
# ADD .ssh-keys /root/.ssh
# RUN ssh-keyscan github.com | tee /root/.ssh/known_hosts >> /home/jenkins/.ssh/known_hosts
# RUN echo 'ssh -T git@github.com'

#Pull Jenkins templates
# RUN apt-get install -y git-core
# RUN git init
# RUN git config user.name 'viralheat-ci'
# RUN git config user.email 'engineering@viralheat.com'
#
# RUN git clone git@github.com:viralheat/jenkins-image.git /home/jenkins/jenkins-image
# RUN cp /home/jenkins/jenkins-image/*.xml /home/jenkins/.jenkins/
# RUN cp -R /home/jenkins/jenkins-image/plugins /home/jenkins/.jenkins/
# RUN cp -R /home/jenkins/jenkins-image/jobs /home/jenkins/.jenkins/
# RUN cp -R /home/jenkins/jenkins-image/updates /home/jenkins/.jenkins/

# RUN chown -R jenkins /home/jenkins/.jenkins

# EXPOSE
EXPOSE 8080
EXPOSE 22

# CMD /usr/local/bin/run
