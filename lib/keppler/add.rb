require 'thor'

module Keppler
  class Add < Thor

    desc 'module', 'Add a new keppler rocket_module'
    def module(*params)
      rocket_name = params[0]
      module_name = params[1]
      fields = params[2..params.length].join(" ")
      system("rails g keppler_add_module #{rocket_name} #{module_name} #{fields} -y")
    end
  end
end