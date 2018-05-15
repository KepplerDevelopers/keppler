#!/usr/bin/env ruby
require 'thor'
require "keppler/version"
require_relative 'add'
require_relative 'delete'

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
      system("cd keppler_#{plugin_name} && scp -r $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/plugins/generators lib/generators")
      puts "> Installed generators"
      system("mkdir keppler_#{plugin_name}/app/views/keppler_#{plugin_name}")
      system("mkdir keppler_#{plugin_name}/app/views/keppler_#{plugin_name}/admin")
      system("scp -r $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/plugins/layouts keppler_#{plugin_name}/app/views/keppler_#{plugin_name}/admin/layouts")
      system("ruby $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/plugins/install.rb keppler_#{plugin_name}")
      system("mkdir keppler_#{plugin_name}/app/policies")
      puts "> Installed policies"
      puts "#{plugin_name} has been created"
    end

    desc 'server', 'Initialize puma server'

    def server
      system("rails s")
    end

    desc 'dep', 'Install dependencies'

    def dep
      system("bundle install")
    end

    desc 'db_conf', 'Create secrets file'

    def db_conf
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

      system("crake db:create db:migrate db:seed")
    end

    desc 'reset', 'Reset to database'
    def reset
      system("rake db:drop db:create db:migrate db:seed")
    end

    desc 'migrate', 'Migrate database'
    def migrate
      system("rake db:migrate")
    end

    desc "add module NAME attr:type attr:type", "Create a new keppler module"
    subcommand "add", Add

    desc "delete module NAME attr:type attr:type", "Delete a keppler module"
    subcommand "delete", Delete
	end
end