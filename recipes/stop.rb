# 1. Enter in maintenance mode by renaming maintenance_.html to maintenance.html
#    becouse nginx show maintenance mode only if -f maintenance.html
# 2. stop thin server by excecuting /opt/robux/bin/thinctl_.sh stop
# 3. kill clockwork, sidekiq process

bash "entering to maintenance mode" do  
  ignore_failure true
  user node.user
  group node.group
  code <<-EOC
    cd #{node.project_dir}/public/
    if [ -f maintenance_.html ]; then
      mv maintenance_.html maintenance.html
    fi
  EOC
end

include_recipe "robux::stop_thin"

# Stopping puma clockwork and sidekiq processes
%w(thin clockwork sidekiq).each do |process_name|
  bash "killing processes thin, clockwork, sidekiq" do
    ignore_failure true
    code <<-EOC
      echo "Terminating #{process_name}"
      sudo kill -9 $(pgrep -f #{process_name} -u #{node.user}) || true
    EOC
    action :run
    only_if { process_name == 'thin' || node.robux.components.attribute?(process_name.to_sym)}
  end
end

# kill sidekick process
bash "killing sidekiq process" do
  ignore_failure true
  code <<-EOC
    cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
    if [ -f 'log/sidekiq.pid' ]; then
      kill `cat log/sidekiq.pid`
      pkill -f sidekiq -u #{node.user}
      rm -f log/sidekiq.pid
    fi
  EOC
  action :run
  only_if { File.exist?(node.project_dir) && node.robux.components.attribute?(:sidekick)}
end

processes_to_kill = {'clockwork' => 'ruby.\{1,\}bin/clockwork.\{1,\}clock.rb',
                     'faye' => 'rackup.\{1,\}faye_server'}
processes_to_kill.each do |process_name, process_pattern|
  bash "kill process by pattern" do
    ignore_failure true
    code <<-EOC
      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
      echo "Terminating: #{process_name}"
      ps uax|grep '#{node.user}.\{1,\}#{process_pattern}'|grep -v grep|cut -d' ' -f2 | xargs kill ; true >/dev/null 2>&1
    EOC
    action :run
    only_if { File.exist?(node.project_dir) && node.robux.components.attribute?(process_name.to_sym)}
  end
end
