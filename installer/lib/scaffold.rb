fields = ARGV
fields = fields[2..fields.length]

fields = fields.join(" ")

if ARGV[0].eql?("new_module")
	system("rails g keppler_scaffold #{ARGV[1]} #{fields} position:integer")
elsif ARGV[0].eql?("delete_module")
	system("rails d keppler_scaffold #{ARGV[1]}")
end