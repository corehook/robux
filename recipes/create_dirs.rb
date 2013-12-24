# Create /opt/robux/app dir 
directory "#{node.robux.dirs.base_dir}/#{node.robux.dirs.app}/" do 
  recursive true
  owner node.user
  group node.user
  action :create
end

# Create /opt/robux/bin dir
directory "#{node.robux.dirs.base_dir}/#{node.robux.dirs.scripts}/" do
  recursive true
  owner node.user
  group node.group
  action :create
end
