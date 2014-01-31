bash "truncate application logs" do
  user node.user
  group node.user
  ignore_failure true
  code <<-EOC
    cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}/script
    chmod +x *.sh
    ./truncate_logs.sh
  EOC
end
