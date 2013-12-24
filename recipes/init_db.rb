# if we do full application deploy, need drop and recreate database 
if node['robux']['database']['init_db'] == 'true'
  include_recipe "robux::db_drop"
  include_recipe "robux::db_create"
  include_recipe "robux::db_populate"
end

include_recipe "robux::db_migrate"

# If need spray bots accounts for testing application perfomance , we must seed all
# this bot accounts from rake task
if node['robux']['bots']['seed'] == 'true'
  include_recipe "robux::db_seed_bots_accounts"
end
