# reseting commit to node.robux.commit
if node.robux.attribute?(:commit)
  bash "reseting commit to #{node.robux.commit}" do
    ignore_failure true
    user node.user
    group node.group
    code <<-EOC
      cd #{node.project_dir}
      git pull 
      git reset --hard #{node.robux.commit}
    EOC
  end
end
