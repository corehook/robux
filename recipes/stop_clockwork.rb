if node['robux']['components']['clockwork']['start'] == 'true'
  bash "start clockwork on #{node.hostname}" do
    user node.user
    group node.user
    ignore_failure true
    code <<-EOC
      source #{node.rvm_env_file}
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
      #{node.rvm_bundle} exec god stop clockwork_jobs SIGTERM
      #{node.rvm_bundle} exec god signal clockwork_jobs SIGTERM
    EOC
  end
end
