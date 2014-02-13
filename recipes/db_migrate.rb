if node.robux.database.attribute?(:migrate)
  if node['robux']['database']['migrate'] == 'true'
    bash "run migrations" do
      user node.user
      group node.group
      code <<-EOC
        cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
        #{node.rvm_bundle} exec rake db:migrate RAILS_ENV=#{node.robux.rails_env}
      EOC
    end
  end
end
