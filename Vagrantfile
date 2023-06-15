Vagrant.configure("2") do |config|
    config.vm.box = "centos/7"
    config.vm.define "server" do |server|
        server.vm.hostname = "server.loc"
        server.vm.network "private_network", ip: "192.168.10.10"
        server.vm.provision :ansible do |ansible|
            ansible.playbook = "playbooks/playbook-server.yml"
        end
    end
    config.vm.define "client" do |client|
        client.vm.hostname = "client.loc"
        client.vm.network "private_network", ip: "192.168.10.20"
        client.vm.provision "shell", inline: <<-SHELL
            mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh
            sed -i '65s/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
            systemctl restart sshd
        SHELL
        client.vm.provision :ansible do |ansible|
            ansible.playbook = "playbooks/playbook-client.yml"
        end
    end
end
        
