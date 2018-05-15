#!/usr/bin/env ruby
require 'thor'
require "keppler/version"

module Keppler
	class Cli < Thor
    desc 'new NAME', 'Create a new keppler app'

    def new(project_name)
      system("scp -r $GEM_HOME/keppler-#{Keppler::VERSION}/installer/core #{project_name}")
    end
	end
end