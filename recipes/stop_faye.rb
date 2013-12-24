#processes_to_kill = {'faye' => 'rackup.\{1,\}faye_server'}
#processes_to_kill.each do |process_name, process_pattern|
#  bash "kill process by pattern" do
#    ignore_failure true
#    code <<-EOC
#      cd #{node.robux.dirs.base_dir}/#{node.robux.dirs.app}
#      echo "Terminating: #{process_name}"
#      ps uax|grep '#{node.user}.\{1,\}#{process_pattern}'|grep -v grep|cut -d' ' -f2 | xargs kill ; true >/dev/null 2>&1
#    EOC
#    action :run
#    only_if { File.exist?(node.project_dir) && node.robux.components.attribute?(process_name.to_sym)}
#  end
#end

bash "stopping faye server with kill command" do  
  ignore_failure true
  user node.user
  group node.group
  code <<-EOC
    process_id=$(pgrep -f faye_server.ru)
    if [ -n $process_id ]
    then
      kill -9 $process_id
    fi
  EOC
end
