#
# Cookbook Name:: inf
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

default_deps

%w[ git ctags vim tmux python ].each do |recipe|
  include_recipe "#{cookbook_name}::#{recipe}"
end

