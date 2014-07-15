#
# Cookbook Name:: inf
# Recipe:: tmux
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'tmux'


all_custom_users do |options|
  cookbook_file "#{options[:homepath]}/.tmux.conf" do
    mode '0644'
    user options[:user]
    source 'tmux/tmux.conf'
  end
end
