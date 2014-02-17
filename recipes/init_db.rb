# if we do full application deploy, need drop and recreate database 
if node['robux']['database']['init_db'] == 'true'
  include_recipe "robux::db_drop"
  include_recipe "robux::db_create"
  include_recipe "robux::db_populate"
end
