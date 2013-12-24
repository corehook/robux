bash "populate db with bots for perfomance testing" do
  user node.user
  group node.group
  ignore_failure true
  code <<-EOC
    cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
    #{node.rvm_bundle} exec rake bots:clear RAILS_ENV=#{node.robux.rails_env}
    #{node.rvm_bundle} exec rake bots:seed RAILS_ENV=#{node.robux.rails_env}
  EOC
end
