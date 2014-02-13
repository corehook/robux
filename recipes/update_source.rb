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
