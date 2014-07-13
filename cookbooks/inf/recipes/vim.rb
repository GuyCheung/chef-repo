#
# Cookbook Name:: inf
# Recipe:: vim
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

require 'etc'

include_recipe "#{cookbook_name}::git"
include_recipe "#{cookbook_name}::ctags"

package 'vim'

(((node['deployment'] || {})['users'] || []) << node['current_user']).uniq.each do |_user|
  userhome = Etc.getpwnam(_user).dir

  cookbook_file "#{userhome}/.vimrc" do
    mode '0644'
    user _user
    source 'vim/vimrc'
  end

  # sed -i not same in gnu and bsd
  case node['platform_family']
  when 'debian', 'rhel'
    execute "sed -i '/\" =For Plugin=/,$d' #{userhome}/.vimrc"
  when 'mac_os_x', 'openbsd'
    execute "sed -i '' '/\" =For Plugin=/,$d' #{userhome}/.vimrc"
  end

  # for .vim dir
  directory "#{userhome}/.vim" do
    user _user
    mode '0775'
  end

  # clone vundle
  execute "git clone https://github.com/gmarik/Vundle.vim.git #{userhome}/.vim/bundle/Vundle.vim" do
    user _user
    only_if "[ ! -e \"#{userhome}/.vim/bundle/Vundle.vim\" ]"
  end

  # install plugins
  execute "vim +PluginInstall +qall" do
    user _user
  end

  cookbook_file "#{userhome}/.vimrc" do
    user _user
    mode '0644'
    source 'vim/vimrc'
  end
end
