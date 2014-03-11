include_recipe "robux::set_hostname"

bash "Update source code from #{node.robux.git.url} branch #{node.robux.git.branch}" do
  ignore_failure true
  user node.user
  group node.group
  code <<-EOC
    cd #{node.project_dir}
    git pull
    git fetch origin #{node.robux.git.branch}
  EOC
end


if node['robux']['git']['commit']
  bash "Reset to commit #{node.robux.git.commit}" do
    ignore_failure true
    user node.user
    group node.group
    code <<-EOC
      cd #{node.project_dir}
      git pull
      git reset --hard #{node.robux.git.commit}
    EOC
  end
end