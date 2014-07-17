#
# Cookbook Name:: inf
# Recipe:: git
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

default_deps

package node['ctags']['package_name']

all_custom_users do |options|
  cookbook_file "#{options[:homepath]}/.ctags" do
    mode '0644'
    user options[:user]
    source 'ctags/ctags'
  end
end
