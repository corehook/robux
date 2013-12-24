# clear /opt/robux/app dir and pull code from git
include_recipe "robux::clean_code"

bash "updating source code" do
  ignore_failure true
  user node.user
  group node.group
  code <<-EOC
    cd #{node.project_dir}
    git pull
    curl http://ws.deploy.om/#{node.robux.rails_env}.commit.txt > last.commit.txt -s
    export LAST_COMMIT=`cat last.commit.txt`
    git reset --hard $LAST_COMMIT
    export LAST_COMMIT=""
  EOC
end

include_recipe "robux::reset_commit"
