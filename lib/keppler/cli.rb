#!/usr/bin/env ruby
require 'thor'
require 'keppler/cli/generate'

module Keppler
	class Cli < Thor
    desc 'sayHello NAME', 'Say hello to NAME'

    def sayHello(name)
      puts "Hello #{name}"
    end
	end
end