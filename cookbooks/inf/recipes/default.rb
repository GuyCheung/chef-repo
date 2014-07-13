#
# Cookbook Name:: inf
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform_family?('mac_os_x')
  include_recipe 'homebrew'
end

%w[ git ctags vim ].each do |recipe|
  include_recipe "#{cookbook_name}::#{recipe}"
end

