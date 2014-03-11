bash "remove application dirs" do
  code <<-EOC
    rm -rf #{node.robux.dirs.base_dir}
  EOC
end

node['robux']['software'].each do |pkg|
  package pkg do
    action :remove
  end
end

