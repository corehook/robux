if attribute?("application")
  node.default[:versions][:ruby] = '2.0.0-p247'
  node.default[:hostname] = node.hostname
  node.default[:homedir] = node.user == 'root' ? "/root" : "/home/#{node.user}"
  node.default[:rvm_dir] = "#{node.homedir}/.rvm"
  node.default[:rvm_ruby_bin_dir] = "#{node.rvm_dir}/gems/ruby-#{node.robux.versions.ruby}@global/bin"
  node.default[:rvm_env_file] = "#{node.rvm_dir}/environments/default"
  rvm_bundle_cmd = "#{node.rvm_ruby_bin_dir}/bundle"
  node.default[:rvm_bundle] = ". #{node.rvm_env_file} ; RAILS_ENV=#{node.robux.rails_env} #{rvm_bundle_cmd}"
  node.default[:rvm_bundle_nohup] = ". #{node.rvm_env_file} ; nohup #{rvm_bundle_cmd}"
  node.default[:project_dir] = "#{node.robux.dirs.base_dir}/#{node.robux.dirs.app}"
  node.default[:scripts_dir] = "#{node.robux.dirs.base_dir}/#{node.robux.dirs.scripts}"
  node.default[:ssl_key] = "#{node.nginx.dirs.ssl}/#{node.nginx.tpl.yek.dst}"
  node.default[:ssl_crt] = "#{node.nginx.dirs.ssl}/#{node.nginx.tpl.crt.dst}"
end

