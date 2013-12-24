node['robux']['tmp']['nodes'].each do |node_name|
  bash "umount remove #{node_name}:#{node.robux.tmp.local_path}" do
    ignore_failure false
    user node.user
    group node.group
    code <<-EOC
      ssh #{node_name} fusermount -u #{node.robux.tmp.local_path}
      sleep 5
    EOC
  end
end
