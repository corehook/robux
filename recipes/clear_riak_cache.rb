if node['robux']['components']['riak']['clean']=='true'
  bash "clear riak cache" do
    user node.user
    group node.group
    ignore_failure true
    code <<-EOC
      source ~/.rvm/scripts/rvm
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
      ./script/clear_cache.sh #{node.robux.rails_env}
      source ~/.rvm/scripts/rvm; RAILS_ENV=#{node.robux.rails_env} #{node.rvm_bundle} exec rake riak:cache:clear 
    EOC
  end
end
