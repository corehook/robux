bash "Add postgresql repo for PostgreSQL 9.2 client" do
  code <<-EOC
      echo deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main > /etc/apt/sources.list.d/pgdg.list
      wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
      apt-get update
  EOC
end

node['robux']['software'].each do |pkg|
  package pkg do
    action :install
  end
end

