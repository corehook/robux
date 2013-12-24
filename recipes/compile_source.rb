# fixing hostname
bash "set host name" do
  puts "Fixing hostname to #{node.nodename}"
  code <<-EOC
    hostname #{node.nodename}
    hostname > /etc/hostname
  EOC
end

db_config = node[:robux][:database]
template "#{node.robux.dirs.base_dir}/#{node.robux.dirs.app}/config/database.yml" do
  source 'database.yml.erb'
  owner node.user
  group node.user
  mode 0644
  variables(
      :rails_env => node.robux.rails_env,
      :adapter => 'postgresql',
      :host => db_config[:host],
      :port => db_config[:port],
      :database => db_config[:name],
      :username => db_config[:user],
      :password => db_config[:password],
      :template => 'template0'
  )
end

bash "truncate logs" do
  user node.user
  group node.user
  ignore_failure true
  code <<-EOC
    cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}/script
    chmod +x *.sh
    ./truncate_logs.sh
  EOC
end


bash "bundle new release" do
  user node.user
  group node.user
  code <<-EOC
    #rm -rf vendor
    cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
    #{node.rvm_bundle} install -j128 --path=vendor --binstubs
  EOC
end

if node['robux']['components']['riak']['clean']=='true'
  bash "clear riak cache" do
    user node.user
    group node.group
    ignore_failure true
    code <<-EOC
      source ~/.rvm/scripts/rvm
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
      ./script/clear_cache.sh #{node.robux.rails_env}
      source ~/.rvm/scripts/rvm; #{node.rvm_bundle} exec rake riak:cache:clear RAILS_ENV=#{node.robux.rails_env}
    EOC
  end
end

include_recipe "robux::compile_assets"
