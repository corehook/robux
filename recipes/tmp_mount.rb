node['robux']['tmp']['nodes'].each do |node_name|
  bash "mount local #{node.robux.tmp.local_path} to #{node_name}:#{node.robux.tmp.local_path}" do
    ignore_failure false
    user node.user
    group node.group
    code <<-EOC
      cd /opt/
      ssh #{node_name} sshfs #{node.robux.tmp.host}:#{node.robux.tmp.remote_path} #{node.robux.tmp.local_path} -o allow_other -o sshfs_debug 
      echo ssh #{node_name} sshfs #{node.robux.tmp.host}:#{node.robux.tmp.remote_path} #{node.robux.tmp.local_path} -o allow_other -o sshfs_debug  >> /tmp/mount.txt
      sleep 5      
    EOC
  end
end
