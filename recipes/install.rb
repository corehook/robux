include_recipe "robux::install_software"
# Create /opt/robux
directory "#{node.robux.dirs.base_dir}" do 
  owner node.user
  group node.user
  action :create
end

# Create /opt/robux/app dir 
directory "#{node.robux.dirs.base_dir}/#{node.robux.dirs.app}/" do 
  owner node.user
  group node.user
  action :create
end

# Create /opt/tmp dir for tmp files
directory "#{node.robux.dirs.tmp}" do
  recursive true
  owner node.user
  group node.group
  action :create
end

# Create /opt/robux/bin dir
directory "#{node.robux.dirs.base_dir}/#{node.robux.dirs.scripts}/" do
  recursive true
  owner node.user
  group node.group
  action :create
end

bash "create new project dir" do
  user node.user
  group node.group
  code <<-EOC
    cd #{node.robux.dirs.base_dir}
    git clone -b #{node.robux.git.branch} #{node.robux.git.url} #{node.robux.dirs.app}
    cd #{node.robux.dirs.app}
    git log -n 1 > public/last.commit.txt
  EOC
end