#
# by Auanassov Chingiz 23.12.2013
# Clean code - рецеп для полного удаления папки с приложением и обновлением кода с репозитория
# адрес репозитория находится в node.robux.git.url
#

if node.robux.git.attribute?(:new)
  if node['robux']['git']['new'] == 'true'
    bash "remove old code if have" do
      ignore_failure true
      user node.user
      group node.group
      code <<-EOC
        rm -rf #{node.project_dir}
        mkdir #{node.project_dir}
        cd #{node.project_dir}
        git clone -b #{node.robux.git.branch} #{node.robux.git.url} . -q
      EOC
    end
  end
end
