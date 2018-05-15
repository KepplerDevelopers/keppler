require 'thor'

module Keppler
  class Generate < Thor

    desc 'module', 'Create a new keppler module'
    def module(name, fields=[])
      system("rails g keppler_scaffold #{name} #{fields} position:integer deleted_at:datetime:index -y")
    end
  end
end