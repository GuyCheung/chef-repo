require 'etc'
require 'fileutils'
require 'berkshelf'

class LinkDependsCookbook
  def initialize(ori_cookbooks_dir, link_target_path)
    @ori_cookbooks_dir = ori_cookbooks_dir
    @link_target_path = link_target_path

    FileUtils.mkdir_p @link_target_path
  end

  def exec
    Dir.glob("#{@ori_cookbooks_dir}/*").each do |cb|
      next unless File.directory?(cb)
      next unless File.exists?("#{cb}/Berksfile")

      berks = Berkshelf::Berksfile.from_file("#{cb}/Berksfile")
      cb_list = berks.install
      cb_list.each do |b_cb|
        next if b_cb.path.to_s == File.expand_path(cb)

        link_name = "#{@link_target_path}/#{b_cb.cookbook_name}"
        #FileUtils.rm_f link_name
        #File.symlink(b_cb.path.to_s, link_name)
        FileUtils.cp_r b_cb.path.to_s, link_name
      end
    end
  end
end

home_dir = Etc.getpwnam(Etc.getlogin).dir
self_path = File.expand_path(File.dirname(__FILE__))

file_cache_path File.join(home_dir, '.chef/cache')
file_backup_path File.join(home_dir, '.chef/backup')

cookbook_path [
  File.join(self_path, '../cookbooks'),
]

json_attribs File.join(self_path, 'node.json')

Process.fork do
  LinkDependsCookbook.new(File.join(self_path, '../cookbooks'), File.join(self_path, '../cookbooks')).exec
end
Process.wait
