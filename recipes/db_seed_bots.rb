bash "run migrations, seed database and seed demo data" do
  ignore_failure true
  user node.user
  group node.group
  code <<-EOC
    cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
    #{node.rvm_bundle} exec rake db:seed RAILS_ENV=#{node.robux.rails_env}
  EOC
end
