if node['robux']['assets_compile'] == 'false'
  bash "download assets from share server" do
    user node.user
    group node.user
    code <<-EOC
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}/public/
      rm #{node.robux.assets_file}
      wget #{node.robux.assets_url}/#{node.robux.assets_file}
      rm -rf assets/
      tar xfz #{node.robux.assets_file}
    EOC
  end
else
  bash "precompile assets" do
    user node.user
    group node.user
    code <<-EOC
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
      #{node.rvm_bundle} exec rake log:clear RAILS_ENV=#{node.robux.rails_env}
      #{node.rvm_bundle} exec rake tmp:clear RAILS_ENV=#{node.robux.rails_env}
      # #{node.rvm_bundle} exec rake assets:clobber RAILS_ENV=#{node.robux.rails_env}
      #{node.rvm_bundle} exec rake assets:clean RAILS_ENV=#{node.robux.rails_env}
      #{node.rvm_bundle} exec rake i18n:js:export RAILS_ENV=#{node.robux.rails_env}
      #{node.rvm_bundle} exec rake -q assets:precompile RAILS_ENV=#{node.robux.rails_env}
    EOC
  end
end

if node['robux']['assets_upload'] == 'true'
  bash "upload compiled assets" do
    user node.user
    group node.group
    code <<-EOC
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}/public/
      tar -czf #{node.robux.assets_file} assets/
      scp #{node.robux.assets_file} dsh@ws.deploy.om:/srv/source/#{node.robux.assets_file}
    EOC
  end
end
