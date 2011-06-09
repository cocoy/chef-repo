include_recipe "alestic_ppa::default"

bash "add_mongo_packages_and_install" do
	    code <<-EOH
	    apt-get -y install build-essential libio-socket-ssl-perl libdatetime-perl 
	    PERL_MM_USE_DEFAULT=1 cpan -fi MongoDB MongoDB::Admin
	    wget https://github.com/cocoy/ec2-consistent-snapshot/raw/master/ec2-consistent-snapshot \
	       -O /usr/bin/ec2-consistent-snapshot 
	    EOH
end
