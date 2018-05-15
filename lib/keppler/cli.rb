#!/usr/bin/env ruby
require 'thor'
require "keppler/version"

module Keppler
	class Cli < Thor
    desc 'new NAME', 'Create a new keppler app'

    def new(project_name)
      system("scp -r $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/core #{project_name}")
      puts '> Created project'
      system("cd #{project_name}")
      system("bundle install")
      puts '> Installed dependences'
      system("scp -r $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/db_conf/conf.yml config/secrets.yml")

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
      puts '> Configured database'

      system("rake db:create db:migrate db:seed")
      puts '> Created database'
      puts "#{project_name} has been created"
    end
	end
end