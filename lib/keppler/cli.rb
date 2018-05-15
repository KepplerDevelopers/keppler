#!/usr/bin/env ruby
require 'thor'

module Keppler
	class Cli < Thor
    desc 'new NAME', 'Create a new keppler app'

    def new(name)
      system("scp -r $GEM_HOME/keppler-#{Keppler::VERSION}/installer/core $PROJECT_NAME")
    end
	end
end