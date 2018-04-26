# puts "Nombre de base de #{ARGV[0]}"
# result = gets.chomp

puts "----------------------------------------------------------"
puts "Database name"
puts "----------------------------------------------------------"
db_name = STDIN.gets.chomp
puts "----------------------------------------------------------"
puts "Database username"
puts "----------------------------------------------------------"
db_username = STDIN.gets.chomp
puts "----------------------------------------------------------"
puts "Database password"
puts "----------------------------------------------------------"
db_password = STDIN.gets.chomp


db_conf = File.readlines("config/secrets.yml")
new_file = []
db_conf.each do |line|
	if line.eql?("    :name: database\n")
		line = "    :name: #{db_name}\n"
	elsif line.eql?("    :username: username\n")
		line = "    :username: #{db_username}\n"
	elsif line.eql?("    :password: password\n")
		line = "    :password: #{db_password}\n"
	end
	new_file.push(line)
end
new_file = new_file.join("")
File.write("config/secrets.yml", new_file)