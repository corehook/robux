if node['robux']['components']['clockwork']['start'] == 'true'
  bash "start clockwork on #{node.hostname}" do
    user node.user
    group node.user
    ignore_failure true
    code <<-EOC
      source #{node.rvm_env_file}
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
      #{node.rvm_bundle} exec god start clockwork_jobs
    EOC
  end

  bash "check if process clockwork is running" do
  ignore_failure true
    code <<-EOC
      echo "Checking if running: clockwork"
      if [ -z "`pgrep -f clockwork -u #{node.user}`" ]; then
        exit 0
      fi
      exit 1
    EOC
    returns 1
  end
end
