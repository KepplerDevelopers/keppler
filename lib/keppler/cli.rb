#!/usr/bin/env ruby
require 'thor'

module Keppler
	class Cli < Thor
    desc 'new NAME', 'Create a new keppler app'

    def new(name)
      puts "Hello #{name} #{$GEM_HOME}"
    end
	end
end