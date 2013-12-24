if node['robux']['components']['sidekiq']['start'] == 'true'
  bash "start sidekiq" do
    user node.user
    group node.group
    code <<-EOC
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
      source #{node.rvm_env_file}
      #{node.rvm_bundle} exec bin/sidekiq -C #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}/config/sidekiq.yml -L log/sidekiq.log -e #{node.robux.rails_env} -d
    EOC
  end
end
