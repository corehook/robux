# init git for application
# there must node.git config in json data

bash "init git repo to #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}" do
  user node.user
  group node.user
  code <<-EOC
    sudo rm -rf #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
    sudo mkdir #{node.robux.dirs.base_dir}/#{node.robux.dirs.app} -p
    sudo chown #{node.user}:#{node.group} #{node.robux.dirs.base_dir} -R
    cd #{node.robux.dirs.base_dir}
    rm -rf #{node.robux.dirs.app}
    git clone -b #{node.robux.git.branch} #{node.robux.git.url} #{node.robux.dirs.app}
  EOC
end
    


