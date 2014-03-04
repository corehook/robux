include_recipe "robux::update_source"
include_recipe "robux::install_configs"
if node['robux']['database']['init_db'] == 'true'
  include_recipe "robux::db_drop"
  include_recipe "robux::db_create"
  include_recipe "robux::db_populate"
end
include_recipe "robux::compile_source"