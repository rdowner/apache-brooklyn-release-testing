# -*- mode: ruby -*-
# vi: set ft=ruby :

preamble = <<-SHELL
eval $( /vagrant/vagrant-activate-proxy.sh )
NORMALUSER=$( getent passwd 1000 | cut -f1 -d: )
SHELL

apt_setup = <<-SHELL
apt-get update
apt-get upgrade -y
apt-get install -y default-jdk zip unzip language-pack-en vim-nox haveged
update-rc.d haveged defaults
SHELL

yum_setup = <<-SHELL
yum update
yum install -y java-1.8.0-openjdk rng-tools wget unzip git
SHELL

setup = <<-SHELL
# Put hosts own SSH host key into global known_hosts file to prevent prompts on 'ssh localhost' commands
cat /etc/ssh/ssh_host_*_key.pub | awk '{print "localhost,127.0.0.1 "$0}' >> /etc/ssh/ssh_known_hosts

# Generate a personal SSH key file, and add to own authorized_keys to prevent prompts on 'ssh localhost' commands
su -l -c 'ssh-keygen -t rsa -b 2048 -N "" -f ~/.ssh/id_rsa; cat ~/.ssh/*.pub >> ~/.ssh/authorized_keys' $NORMALUSER

# Install the Apache Brooklyn KEYS for gnupg
su -l -c 'wget -O ~/apache-brooklyn-KEYS https://dist.apache.org/repos/dist/release/brooklyn/KEYS' $NORMALUSER
su -l -c 'gpg --import ~/apache-brooklyn-KEYS' $NORMALUSER

# Install the "training" brooklyn.properties file (which disables all authentication on web API/UI)
su -l -c 'mkdir -p ~/.brooklyn' $NORMALUSER
su -l -c 'wget -q -O.brooklyn/brooklyn.properties https://raw.githubusercontent.com/apache/brooklyn-dist/master/vagrant/src/main/vagrant/files/brooklyn.properties' $NORMALUSER
su -l -c 'chmod -R go= ~/.brooklyn' $NORMALUSER

# su -l -c "tar xzf /vagrant/apache-brooklyn-*-bin.tar.gz" $NORMALUSER
# su -l -c "tar xzf /vagrant/apache-brooklyn-*-client-cli-linux.tar.gz" $NORMALUSER
SHELL


Vagrant.configure("2") do |config|
    config.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
    config.vm.define "ubuntu1604" do |ubuntu1604|
        ubuntu1604.vm.box = "ubuntu/xenial64"
        ubuntu1604.vm.network "forwarded_port", guest: 8081, host: 8581
        ubuntu1604.vm.provision "shell", inline: preamble+apt_setup+setup
    end
    config.vm.define "centos7" do |centos7|
        centos7.vm.box = "centos/7"
        centos7.vm.network "forwarded_port", guest: 8081, host: 8781
        centos7.vm.provision "shell", inline: preamble+yum_setup+setup
    end
#    config.vm.define "centos6" do |centos6|
#        centos6.vm.box = "centos/6"
#        centos6.vm.network "forwarded_port", guest: 8081, host: 8681
#        centos6.vm.provision "shell", inline: <<-SHELL
#eval $( /vagrant/vagrant-activate-proxy.sh )
#NORMALUSER=$( getent passwd 500 | cut -f1 -d: )
#yum update
#yum install -y java-1.8.0-openjdk rng-tools wget
#service rngd start
#cat /etc/ssh/ssh_host_*_key.pub | awk '{print "localhost,127.0.0.1 "$0}' >> /etc/ssh/ssh_known_hosts
#su -l -c 'ssh-keygen -t rsa -b 2048 -N "" -f ~/.ssh/id_rsa; cat ~/.ssh/*.pub >> ~/.ssh/authorized_keys' $NORMALUSER
#su -l -c 'mkdir -p ~/.brooklyn' $NORMALUSER
#su -l -c 'wget -q -O.brooklyn/brooklyn.properties https://raw.githubusercontent.com/apache/brooklyn-dist/master/vagrant/src/main/vagrant/files/brooklyn.properties' $NORMALUSER
#su -l -c 'chmod -R go= ~/.brooklyn' $NORMALUSER
#su -l -c "tar xzf /vagrant/apache-brooklyn-*-bin.tar.gz" $NORMALUSER
#su -l -c "tar xzf /vagrant/apache-brooklyn-*-client-cli-linux.tar.gz" $NORMALUSER
#        SHELL
#    end
end
