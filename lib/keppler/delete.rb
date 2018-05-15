require 'thor'

module Keppler
  class Delete < Thor

    desc 'module', 'Delete a keppler module'
    def module(params)
      fields = params
      fields = fields[2..fields.length]
      system("rails d keppler_scaffold #{params[0]} #{fields} position:integer deleted_at:datetime:index -y")
    end
  end
end