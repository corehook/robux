bash "set hostname to #{node.nodename}" do
  user node.user
  group node.group
  ignore_failure true
  code <<-EOC
    sudo hostname #{node.nodename}
    sudo sh -c 'hostname > /etc/hostname'
  EOC
end