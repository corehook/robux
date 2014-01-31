bash "bundle new release" do
  user node.user
  group node.user
  code <<-EOC
    #rm -rf vendor
    cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
    #{node.rvm_bundle} install -j128 --path=vendor --binstubs
  EOC
end
