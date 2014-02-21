bash "run migrations, seed database and seed demo data" do
  ignore_failure true
  user node.user
  group node.group
  code <<-EOC
    cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
    #{node.rvm_bundle} exec rake db:migrate RAILS_ENV=#{node.robux.rails_env}
  EOC
end

include_recipe "robux::db_seed"
include_recipe "robux::db_demo_data_seed"
