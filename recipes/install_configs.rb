# write thin.yml config file for thin server
# path : /opt/robux/app/config/thin.yml
template "#{node.robux.dirs.base_dir}/app/config/thin.yml" do
  source 'thin.yml.erb'
  owner node.user
  group node.user
  mode 0775
  variables({
    :user       => node.user,
    :group      => node.group,
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
