#
# Cookbook Name:: inf
# Definition:: default_deps
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

define :default_deps do

  if platform_family?('mac_os_x')
    include_recipe 'homebrew'
  end

end
