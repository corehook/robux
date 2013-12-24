# In this recipe we try to install packages required to application
# in this case is :
# 1. PostgreSQL client
# 2. Git
# 3. Libs

bash "Add postgresql repo for PostgreSQL 9.2 client" do
  code <<-EOC
      echo deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main > /etc/apt/sources.list.d/pgdg.list
      wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
      apt-get update
  EOC
end


['redis-server', 'postgresql-client-9.2', 'git', 'libqt4-dev', 'libpq-dev', 'libmagickwand-dev', 'gcc', 'gawk', 'libreadline6-dev', 'libyaml-dev', 'libsqlite3-dev', 'sqlite3', 'libxslt1-dev', 'autoconf', 'libgdbm-dev',
 'libncurses5-dev', 'automake', 'bison', 'libffi-dev'].each do |pkg_for_rvm|
  package pkg_for_rvm
end

