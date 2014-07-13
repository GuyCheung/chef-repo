name             'inf'
maintainer       'Guy Cheung'
maintainer_email 'guy.xtafcusqt@gmail.com'

license          'GPL v2'
description      'For development env initialize.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "homebrew"

provides "inf::vim"
provides "inf::git"
provides "inf::ctags"

recipe "inf", "for all tools install"

supports 'ubuntu'
supports 'centos'
supports 'mac_os_x'
