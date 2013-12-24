# Drop application database
if node['robux']['database']['drop'] == 'true'
  bash "dropping database with rake db:drop" do
    code <<-EOC
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
      source ~/.rvm/scripts/rvm
      #{node.rvm_bundle} exec rake db:drop RAILS_ENV=#{node.robux.rails_env}
    EOC
  end
end
