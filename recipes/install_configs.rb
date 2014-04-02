# write thin.yml config file for thin server
# path : /opt/robux/app/config/thin.yml
template "#{node.robux.dirs.base_dir}/app/config/thin.yml" do
  source 'thin.yml.erb'
  owner node.user
  group node.user
  mode 0775
  variables({
    :user       => node.user,
    :group      => node.user,
    :pid        => "#{node.robux.dirs.base_dir}/app/tmp/pids/thin.pid",
    :timeout    => "30",
    :wait       => "30",
    :log         => "#{node.robux.dirs.base_dir}/app/log/thin.log",
    :max_conns  => "1024",
    :env        => node.robux.rails_env,
    :servers    => "4",
    :chdir      => "#{node.robux.dirs.base_dir}/app",
  })
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

if node['robux']['components']['clockwork']['start'] == 'true'
  template "#{node.robux.dirs.base_dir}/app/clock.monitor.god" do
    source 'clock.monitor.god.erb'
    owner node.user
    group node.user
    variables({
      :RAILS_ROOT => node.project_dir,
      :env        => node.robux.rails_env,
      :user       => node.user,
      :group      => node.group
    })
  end
end