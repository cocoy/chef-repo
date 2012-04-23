#
# Cookbook Name:: hadoop
# Recipe:: cloudera
#
# Copyright 2011, Robin Wenglewski
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"
include_recipe "apt"

apt_repository 'cloudera' do
	uri "http://archive.cloudera.com/debian/"
	distribution "#{node[:lsb][:codename]}-cdh3"
	#if {node[:lsb][:release]} > 10.04  do
	if node[:platform_version].to_f > 10.04  
		distribution "lucid-cdh3"
	end
	components ["contrib"]
	keyserver "pgp.mit.edu"
	#key "http://archive.cloudera.com/debian/archive.key"
	key "327574EE02A818DD" 
	#key "D1CA74A1" 
	action :add
end

execute "cloudera-add-key" do 
	command "apt-key adv --keyserver pgp.mit.edu --recv-keys 327574EE02A818DD && apt-get update" 
end

# package "hadoop" and others causes the following error ob ubuntu 10.04:
# [Sun, 25 Sep 2011 02:38:48 -0700] FATAL: Chef::Exceptions::Package: package[hadoop] (hadoop::default line 34) 
# had an error: apt does not have a version of package hadoop
# installing it manually work, though
%w(hadoop hadoop-conf-pseudo hadoop-namenode hadoop-jobtracker hadoop-tasktracker hadoop-datanode).each do |pkg|
  execute "apt-get -y install #{pkg}"
end

# hue has to be installed before hadoop services are started
if node['hadoop']['hue']["install"]
  execute "apt-get -y install hue"
end

%w(hadoop-datanode hadoop-tasktracker hadoop-namenode hadoop-jobtracker).each do |pkg|
  pkg = pkg.split("-").insert(1, "0.20").join("-")
  service pkg do
    supports :start => true, :stop => true, :restart => true
    action [:start, :enable]
  end
end


if node['hadoop']['hue']["service"]
  service "hue" do
    supports :start => true, :stop => true, :restart => true
  end
end

# unfortunately, this seems neccessary for hue to start correctly
log "restarting hue 2 times" do
  2.times do
    notifies :restart, resources(:service => "hue"), :immediately
  end
end
