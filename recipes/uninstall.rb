bash "remove application dirs" do
  code <<-EOC
    rm -rf #{node.robux.dirs.base_dir}
  EOC
end

['redis-server', 'postgresql-client-9.2', 'git', 'libqt4-dev', 'libpq-dev', 'libmagickwand-dev', 'gcc', 'gawk', 'libreadline6-dev', 'libyaml-dev', 'libsqlite3-dev', 'sqlite3', 'libxslt1-dev', 'autoconf', 'libgdbm-dev',
 'libncurses5-dev', 'automake', 'bison', 'libffi-dev'].each do |pkg_for_rvm|
  package pkg_for_rvm do
    action :remove
  end
end


