# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.provider :virtualbox do |vb|
    vb.memory = '2096'
    vb.cpus = '1'
  end
  config.vm.hostname = "myserver.local"
  config.vm.network "private_network", ip: "192.168.56.4", hostname: true
end
