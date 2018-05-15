#!/usr/bin/env ruby
require 'thor'
require "keppler/version"

module Keppler
	class Cli < Thor

    desc 'new NAME', 'Create a new keppler app'

    def new(project_name)
      system("scp -r $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/core #{project_name}")
      puts '> Created project'
      system("cd #{project_name} && bundle install")
      puts '> Installed dependences'
      system("scp -r $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/db_conf/conf.yml #{project_name}/config/secrets.yml")

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


      db_conf = File.readlines("#{project_name}/config/secrets.yml")
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
      File.write("#{project_name}/config/secrets.yml", new_file)
      puts '> Configured database'

      system("cd #{project_name} && rake db:create db:migrate db:seed")
      puts '> Created database'
      puts "#{project_name} has been created"
    end

    desc 'plugin NAME', 'Create a new keppler plugin'

    def plugin(plugin_name)
      system("rails plugin new keppler_#{plugin_name} --mountable")
      puts "> Created scaffold"
      system("cd keppler_#{plugin_name} && scp -r $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/plugins/generators keppler_#{plugin_name}/lib/generators")
      puts "> Installed generators"
      system("mkdir keppler_#{plugin_name}/app/views/keppler_$PLUGIN_NAME")
      system("mkdir keppler_#{plugin_name}/app/views/keppler_$PLUGIN_NAME/admin")
      system("scp -r $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/plugins/layouts keppler_#{plugin_name}/app/views/keppler_$PLUGIN_NAME/admin/layouts")
      system("ruby $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/plugins/install.rb keppler_#{plugin_name}")
      system("mkdir keppler_#{plugin_name}/app/policies")
      puts "> Installed policies"
      puts "#{plugin_name} has been created"
    end
	end
end