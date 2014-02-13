# install nginx
include_recipe "robux::install_nginx_and_restart"

include_recipe "robux::install_software"
include_recipe "robux::install_scripts"
include_recipe "robux::create_dirs"
include_recipe "robux::init_git"

include_recipe "robux::start_deploy_without_db"
