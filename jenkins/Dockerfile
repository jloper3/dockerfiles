FROM jenkins

USER root
RUN apt-get -y update
RUN apt-get install -y curl build-essential

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

RUN curl -L https://get.rvm.io | bash -s stable


ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /usr/local/rvm/bin/rvm-shell && rvm requirements
RUN /usr/local/rvm/bin/rvm-shell && rvm install 2.0.0
RUN /usr/local/rvm/bin/rvm-shell && rvm use 2.0.0 --default

USER jenkins
ENV PATH /usr/local/rvm/rubies/ruby-2.0.0-p247/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

