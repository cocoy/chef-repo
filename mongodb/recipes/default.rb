
# Add apt public key for mongodb repo

ubuntu_version = node[:platform_version]
ubuntu_version.gsub! '.0', '.'

execute "add 10gen apt key" do
	  command "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
    	  action :nothing
end

execute "apt-get update" do
	  action :nothing
end

execute  "echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' >> /etc/apt/sources.list"  do 
	user 'root'
	not_if 'grep mongodb /etc/apt/sources.list'
	notifies :run, resources(:execute => "add 10gen apt key"), :immediately
  	notifies :run, resources(:execute => "apt-get update"), :immediately

end

package "mongodb-10gen" do 
 	action :install
end







