bash "start thin" do
  ignore_failure true
  user node.user
  group node.user
  code <<-EOC
    source #{node.homedir}/.rvm/environments/default
    cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}/
    RAILS_ENV=#{node.robux.rails_env} bundle exec thin -C config/thin.yml start
  EOC
  action :run
end
