require 'thor'

module Keppler
  class Generate < Thor

    desc 'module', 'Create a new keppler module'
    def module(*params)
      params = params.split(" ")
      module_name = params[0]
      fields = params[2..params.length]
      system("rails g keppler_scaffold #{module_name} #{fields} position:integer deleted_at:datetime:index -y")
    end
  end
end