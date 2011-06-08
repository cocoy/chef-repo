
# Add apt public key for alestic.com ppa 

#ubuntu_version = node[:platform_version]
#ubuntu_version.gsub! '.0', '.'
#
#
codename = node[:lsb][:codename]

execute "add alestic apt key" do
	  command "apt-key adv --keyserver keyserver.ubuntu.com --recv BE09C571"
    	  action :nothing
end

execute "apt-get update" do
	  action :nothing
end

execute  "echo 'deb http://ppa.launchpad.net/alestic/ppa/ubuntu #{codename} main' >> /etc/apt/sources.list"  do 
	user 'root'
	not_if 'grep alestic /etc/apt/sources.list'
	notifies :run, resources(:execute => "add alestic apt key"), :immediately
  	notifies :run, resources(:execute => "apt-get update"), :immediately

end

package "ec2-consistent-snapshot" do 
 	action :install
end

