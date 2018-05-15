require 'thor'

module Keppler
  class Delete < Thor
    desc 'module', 'Delete a keppler module'
    def module(name, fields=[])
      system("rails d keppler_scaffold #{name} #{fields} position:integer deleted_at:datetime:index -y")
    end
  end
end