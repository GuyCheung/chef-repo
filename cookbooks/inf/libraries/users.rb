#
# Cookbook Name:: inf
# Libraries: users
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

require 'etc'

class Chef
  class Recipe
    def all_custom_users(&block)
      (((node['deployment'] || {})['users'] || []) << node['current_user']).uniq.each do |_user|
        userhome = Etc.getpwnam(_user).dir
        block.call(:user => _user, :homepath => userhome)
      end
    end
  end
end
