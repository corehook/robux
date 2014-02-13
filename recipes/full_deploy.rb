include_recipe "robux::update_source"
include_recipe "robux::compile_source"
if node['robux']['database']['init_db'] == 'true'
  include_recipe "robux::db_drop"
  include_recipe "robux::db_create"
  include_recipe "robux::db_populate"
end
