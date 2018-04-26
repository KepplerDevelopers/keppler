#!/usr/bin/env ruby
require 'thor'
require 'keppler/cli/generate'

module Keppler
	class Generate < Thor
		# [...]

    desc "g new [project name]", "Create a new keppler project"
    subcommand "generate", Keppler::CLI::Generate
	end
end