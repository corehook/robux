bash "stoping thin server" do
  ignore_failure true
  user node.user
  group node.group
  code <<-EOC
    source #{node.home_dir}/.rvm/environments/default
    cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
    RAILS_ENV=#{node.robux.rails_env} #{node.rvm_bundle} exec thin -C config/thin.yml stop
  EOC
end
