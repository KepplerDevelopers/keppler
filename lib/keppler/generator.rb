require 'thor'

module Keppler
  class Generator < Thor

    def new_module(name, fields=[])
      system("rails g keppler_scaffold #{name} #{fields} position:integer deleted_at:datetime:index -y")
    end
  end
end