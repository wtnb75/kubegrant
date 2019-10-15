
boxes = [
  ["master",  "ubuntu/bionic64", "192.168.3.10", "192.168.4.10"],
  ["worker1", "ubuntu/xenial64", "192.168.3.20",  nil],
  ["worker2", "ubuntu/bionic64", "192.168.3.21",  "192.168.4.21"],
  ["worker3", "centos/7",        "192.168.3.22",  "192.168.4.22"],
  ["worker4", "generic/centos8", "192.168.3.23",  nil],
  #["nfs",    "ubuntu/bionic64", "192.168.3.249", "192.168.4.249"],
  #["s3",     "ubuntu/bionic64", "192.168.3.248", "192.168.4.248"],
  #["db",      "ubuntu/bionic64", nil,             "192.168.4.247"],
]

Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect=true
  end
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = ENV["http_proxy"]
    config.proxy.https    = ENV["https_proxy"]
    config.proxy.no_proxy = "localhost,127.0.0.1,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12"
  end
  config.vbguest.auto_update=false
  config.vm.box_check_update=false
  boxes.each do|name,box,addr1,addr2|
    config.vm.define name do|cfg|
      cfg.vm.box = box
      cfg.vm.provider "virtualbox" do |vb|
        vb.cpus="2"
        vb.memory="2048"
        #vb.customize ["createmedium", "disk", "--filename", "#{name}-sdb.vmdk", "--format", "VMDK", "--size", 100*1024]
        #vb.customize ["storageattach", :id, "--storagectl", "SCSI", "--port", 1, "--device", 0, "--type", "hdd", "--medium", "#{name}-sdb.vmdk"]
      end

      if addr1
        cfg.vm.network "private_network", ip: addr1, virtualbox__intnet: "internal1"
      end
      if addr2
        cfg.vm.network "private_network", ip: addr2, virtualbox__intnet: "internal2"
      end
      cfg.vm.hostname = "#{name}.local"
      cfg.vm.provision "ansible" do|ansible|
        ansible.playbook = "ansible/site.yml"
        ansible.groups = {
          "k8s_master" => boxes.select{|e| e[0].start_with? "master"}.map{|e| e[0]},
          "k8s_worker" => boxes.select{|e| e[0].start_with? "worker"}.map{|e| e[0]},
          "centos" => boxes.select{|e| e[1].match "centos"}.map{|e| e[0]},
          "ubuntu" => boxes.select{|e| e[1].start_with? "ubuntu"}.map{|e| e[0]},
          "database" => boxes.select{|e| e[0].start_with? "db"}.map{|e| e[0]},
        }
        if Vagrant.has_plugin?("vagrant-proxyconf")
          ansible.extra_vars = {
            proxy: {
              http_proxy: config.proxy.http,
              https_proxy: config.proxy.http,
              HTTP_PROXY: config.proxy.https,
              HTTPS_PROXY: config.proxy.https,
              no_proxy: config.proxy.no_proxy,
              NO_PROXY: config.proxy.no_proxy,
            }
          }
        end
      end
    end
  end
end
