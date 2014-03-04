puts "Test recipe called :)"
if node['robux']['database']['init_db'].eql? 'true'
  puts "need initdb"
end
