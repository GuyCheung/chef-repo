#
# Cookbook Name:: inf
# Recipe:: vim
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

default_deps

package node['python']['package_name']

include_recipe 'python::pip'
include_recipe 'python::virtualenv'

all_custom_users do |options|

  directory "#{options[:homepath]}/.pip" do
    user options[:user]
    mode 0755
  end

  cookbook_file "#{options[:homepath]}/.pip/pip.conf" do
    user options[:user]
    mode '0644'
    source 'python/pip.conf'
  end

end

python_pip 'ipython'
