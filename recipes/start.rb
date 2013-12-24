if node['robux']['components']['redis']['clean'] == 'true'
  bash "clear redis db" do
    user node.user
    group node.group
    ignore_failure true
    code <<-EOC
      redis-cli -h #{node.robux.components.redis.host} FLUSHALL
    EOC
  end
end

include_recipe "robux::start_faye"
include_recipe "robux::start_sidekiq"
include_recipe "robux::start_clockwork"
include_recipe "robux::start_thin"

#
# Start brakeman for security checks
bash "start brakeman" do
  ignore_failure true
  user node.user
  group node.group
  code <<-EOC
    source ~/.rvm/environments/default
    cd #{node.robux.dirs.base_dir}/app
    bundle exec brakeman -m -o public/last.security.html
  EOC
end

if node['robux']['components']['clockwork']['start'] == 'true'
  bash "check if process clockwork is running" do
  ignore_failure true
    code <<-EOC
      echo "Checking if running: clockwork"
      if [ -z "`pgrep -f clockwork -u #{node.user}`" ]; then
        exit 0
      fi
      exit 1
    EOC
    returns 1
  end
end

if node['robux']['components']['sidekiq']['start'] == 'true'
  bash "check if process sidekiq is running" do
  ignore_failure true
    code <<-EOC
      echo "Checking if running sidekiq"
      if [ -z "`pgrep -f sidekiq -u #{node.user}`" ]; then
        exit 0
      fi
      exit 1
    EOC
    returns 1
  end
end

processes_to_check = {'thin' => 'thin', 'faye' => 'rackup.\{1,\}faye_server' }
processes_to_check.each do |process_name, process_pattern|
  bash "check if process #{process_name} is running" do
  ignore_failure true
    code <<-EOC
      echo "Checking if running: #{process_name}"
      if [ -z "`pgrep -f #{process_name} -u #{node.user}`" ]; then
        exit 1
      fi
      exit 0
    EOC
    returns 0
  end
end

bash "exiting maintenance mode and log last deploy data" do
  ignore_failure true
  user node.user
  group node.group
  code <<-EOC
    cd #{node.project_dir}/public
    date > last.deploy.txt
    if [ -f maintenance.html ]; then
      mv maintenance.html maintenance_.html
    fi
    cd ../
    git log -n 1 > public/last.commit.txt
  EOC
end
