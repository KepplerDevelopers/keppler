require 'thor'

module Keppler
  class Generate < Thor

    desc 'module', 'Create a new keppler module'
    def module(params)
      byebug
      fields = params
      fields = fields[2..fields.length]
      system("rails g keppler_scaffold #{params[0]} #{fields} position:integer deleted_at:datetime:index -y")
    end
  end
end