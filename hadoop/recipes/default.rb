#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2011, Robin Wenglewski
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
   when "debian","ubuntu" 
	include_recipe "hadoop::cloudera"
   when "redhat","centos","suse"
	include_recip "haddop::source"
end
