#
# Cookbook Name:: inf
# Recipe:: git
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'debian'
  package 'exuberant-ctags'
when 'mac_os_x'
  package 'ctags'
when 'rhel'
  package 'ctags'
end

all_custom_users do |options|
  cookbook_file "#{options[:homepath]}/.ctags" do
    mode '0644'
    user options[:user]
    source 'ctags/ctags'
  end
end
