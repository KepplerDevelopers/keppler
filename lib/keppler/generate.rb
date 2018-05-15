require 'thor'

module Keppler
  class Generate < Thor

    desc 'module', 'Create a new keppler module'
    def module(*params)
      module_name = params[0]
      fields = params[1..params.length].join(" ")
      system("rails g keppler_scaffold #{module_name} #{fields} position:integer deleted_at:datetime:index -y")
    end
  end
end