#
# Cookbook Name:: inf
# Attributes:: inf
#

case node['platform_family']
when 'debian'
  default['ctags']['package_name'] = 'exuberant-ctags'
  default['python']['package_name'] = 'python2.7'

when 'mac_os_x'
  default['ctags']['package_name'] = 'ctags'

  # for inf::python recipe
  default['python']['package_name'] = 'python'

when 'rhel'
  default['ctags']['package_name'] = 'ctags'
  default['python']['package_name'] = 'python2.7'
end

