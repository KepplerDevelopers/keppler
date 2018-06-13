require 'thor'

module Keppler
  class Rocket < Thor

    desc 'rocket new NAME', 'Create a new keppler plugin'

    def new(plugin_name)
      plugin_name = plugin_name.downcase
      system("rails plugin new keppler_#{plugin_name} --mountable")
      puts "> Created scaffold"
      system("cd keppler_#{plugin_name} && scp -r $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/plugins/generators lib/generators")
      puts "> Installed generators"
      system("mkdir keppler_#{plugin_name}/app/views/keppler_#{plugin_name}")
      system("mkdir keppler_#{plugin_name}/app/views/keppler_#{plugin_name}/admin")
      system("scp -r $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/plugins/layouts keppler_#{plugin_name}/app/views/keppler_#{plugin_name}/admin/layouts")
      system("ruby $GEM_HOME/gems/keppler-#{Keppler::VERSION}/installer/plugins/install.rb keppler_#{plugin_name}")
      system("mkdir keppler_#{plugin_name}/app/policies")
      puts "> Installed policies"
      puts "#{plugin_name} has been created"
    end

    desc 'rocket build NAME', 'Build a keppler plugin'

    def build(plugin_name)
      system("zip -r #{plugin_name}.rocket #{plugin_name}/*")
    end
  end
end