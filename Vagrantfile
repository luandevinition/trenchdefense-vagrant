Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu16"
  config.vm.hostname = "ubuntu-xenial"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3306, host: 33060
  config.vm.network "forwarded_port", guest: 22, host: 2222, host_ip: "127.0.0.1", id: 'ssh'

  config.vm.network :private_network, ip: '192.168.70.70'
  config.vm.synced_folder '.', '/vagrant'
  config.vm.synced_folder "./trenchdefense-back", "/var/www/trenchdefense-back", owner: "www-data", group: "vagrant", mount_options: ["dmode=775,fmode=775"]

  #install Nginx, PHP-FPM 7.1 + extensions, MySQL, Composer
  #config.vm.provision "shell", path: "provision.sh"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024]
    vb.customize ["modifyvm", :id, "--cpus", 1]
  end
end
