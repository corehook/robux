if node['robux']['components']['clockwork']['start'] == 'true'
  bash "start clockwork" do
    user node.user
    group node.user
    ignore_failure true
    code <<-EOC
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
      source #{node.rvm_env_file}
      #{node.rvm_bundle} exec clockwork clock.rb > log/clockwork.log < /dev/null 2>&1 &
    EOC
  end
end
