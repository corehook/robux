# Create database for application
if node['robux']['database']['create'] == 'true'
  bash "creating database with rake db:create" do
    code <<-EOC
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
      source ~/.rvm/scripts/rvm
      #{node.rvm_bundle} exec rake db:create RAILS_ENV=#{node.robux.rails_env}
    EOC
  end
end


