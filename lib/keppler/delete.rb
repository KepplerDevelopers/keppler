require 'thor'

module Keppler
  class Delete < Thor

    desc 'module', 'Delete a keppler module'
    def module(*params)
      rocket_name = params[0]
      module_name = params[1]
      fields = params[1..params.length].join(" ")
      system("rails d keppler_delete_module #{rocket_name} #{module_name} -y")
    end
  end
end