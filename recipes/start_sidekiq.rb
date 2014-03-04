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



if node['robux']['components']['sidekiq']['start'] == 'true'
  bash "check if process sidekiq is running" do
  ignore_failure true
    code <<-EOC
      echo "Checking if running sidekiq"
      if [ -z "`pgrep -f sidekiq -u #{node.user}`" ]; then
        exit 0
      fi
      exit 1
    EOC
    returns 1
  end
end
