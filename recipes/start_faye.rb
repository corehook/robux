if node.robux.components.attribute?(:faye)
  faye_env_vars = node.robux.components.attribute?(:redis) ? "redis_host=#{node.robux.components.redis.host} redis_port=#{node.robux.components.redis.port} " : ''
  rails_env = "RAILS_ENV=#{node.robux.rails_env}"
  execute "start faye with rackup" do
    # note: depends on 'patch_settings' recipe
    cwd node.project_dir
    user node.user
    group node.user
    # note '-E <environment>' is not Rails environment but Faye run mode (Faye has known issues in development mode)
    # note: 'export' is effective only within current command
    command("export #{faye_env_vars} #{rails_env} ; #{node.rvm_bundle_nohup} exec rackup faye_server.ru -E #{node.robux.components.faye.environment} " +
                "-s thin -p #{node.robux.components.faye.port} > #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}/log/faye.log < /dev/null 2>&1 &")
    action :run
  end
end
