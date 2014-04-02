include_recipe "robux::install_software"
# Create /opt/robux
directory "#{node.robux.dirs.base_dir}" do 
  owner node.user
  group node.group
  action :create
end

# Create /opt/robux/app dir 
directory "#{node.robux.dirs.base_dir}/#{node.robux.dirs.app}/" do 
  owner node.user
  group node.group
  action :create
end

if node['robux']['dirs']['tmp']
# Create /opt/tmp dir for tmp files
  directory "#{node.robux.dirs.tmp}" do
    recursive true
    owner node.user
    group node.group
    action :create
  end
end

# Create /opt/robux/bin dir
directory "#{node.robux.dirs.base_dir}/#{node.robux.dirs.scripts}/" do
  recursive true
  owner node.user
  group node.group
  action :create
end

bash "Создаю папку для проекта по адресу #{node.robux.dirs.base_dir} из репозитория #{node.robux.git.url}/#{node.robux.git.branch}" do
  user node.user
  group node.group
  code <<-EOC
    cd #{node.robux.dirs.base_dir}
    git clone -b #{node.robux.git.branch} #{node.robux.git.url} #{node.robux.dirs.app}
    cd #{node.robux.dirs.app}
  EOC
end
