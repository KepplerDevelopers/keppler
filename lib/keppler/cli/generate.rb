require 'thor'
module Keppler
  module CLI
    class Generate < Thor
      desc "search URL", "Search hn.algolia.com for a url mentioned on Hackernews"
      # option :tags
      def new( project_name )
      	gem_path = File.dirname(__FILE__)
      	project_path = Dir.pwd

      	system "cp #{gem_path}/template/index.html #{project_path}/index.html"

      	puts "Gempath: #{gem_path}"
      	puts "project_path: #{project_path}"
        puts "#{project_name} has created"
      end
    end
  end
end