#!/usr/bin/env ruby
require 'thor'

module Keppler
	class Cli < Thor
    desc 'new NAME', 'Create a new keppler app'

    def new(name)
      path = gem path keppler
      puts "Hello #{name} #{path}"
    end
	end
end