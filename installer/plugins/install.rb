gemspec = File.readlines("#{ARGV[0]}.gemspec")

gemspec[11] = "  s.homepage    = 'http://keppler.io'\n"
gemspec[12] = "  s.summary     = '#{ARGV[0]}'\n"
gemspec[13] = "  s.description = '#{ARGV[0]}'\n"

gemspec.insert(17, "  s.test_files = Dir['test/**/*']\n")

# gemspec.delete_at(19)
# gemspec.delete_at(20)

gemspec[19] = "  s.add_dependency 'rails', '5.2.0'\n"
gemspec[20] = "  s.add_dependency 'simple_form'\n"
gemspec.insert(21, "  s.add_dependency 'haml_rails'\n")
gemspec.insert(22, "  s.add_dependency 'pundit'\n")
gemspec.insert(23, "  s.add_development_dependency 'pg'\n")
gemspec.delete_at(24)
gemspec = gemspec.join("")

File.write("#{ARGV[0]}.gemspec", gemspec)


engine = File.readlines("lib/#{ARGV[0]}/engine.rb")

engine.insert(3, "    paths['config/locales']\n")
engine.insert(4, "    config.generators do |g|\n")
engine.insert(5, "      g.template_engine :haml\n")
engine.insert(6, "    end\n")
engine.insert(7, "\n")
engine.insert(8, "    config.to_prepare do\n")
engine.insert(9, "      ApplicationController.helper(ApplicationHelper)\n")
engine.insert(10, "    end\n")

engine = engine.join("")

File.write("lib/#{ARGV[0]}/engine.rb", engine)


route = File.readlines("config/routes.rb")

route.insert(1, "  namespace :admin do\n")
route.insert(2, "    scope :#{ARGV[0].split('_').drop(1).join('')}, as: :#{ARGV[0].split('_').drop(1).join('')} do\n")
route.insert(3, "    end\n")
route.insert(4, "  end\n")

route = route.join("")

File.write("config/routes.rb", route)

system("scp -r ~/.keppler/plugins/config/menu.yml config/menu.yml")

menu = File.readlines("config/menu.yml")

menu[1] = "  #{ARGV[0]}:\n"
menu[2] = "    name: #{ARGV[0].split('_').map(&:capitalize).join(' ')}\n"

menu = menu.join("")

File.write("config/menu.yml", menu)

system("scp -r ~/.keppler/plugins/config/locales config/locales")

project = ARGV[0].to_s

locales = File.readlines("config/locales/en.yml")

locales[3] = "      #{project.gsub('_', '-')}: #{ARGV[0].split('_').map(&:capitalize).join(' ')}\n"
locales[4] = "      #{project.gsub('_', '-')}-submenu:\n"

locales = locales.join("")

File.write("config/locales/en.yml", locales)

locales = File.readlines("config/locales/es.yml")

locales[3] = "      #{project.gsub('_', '-')}: #{ARGV[0].split('_').map(&:capitalize).join(' ')}\n"
locales[4] = "      #{project.gsub('_', '-')}-submenu:\n"

locales = locales.join("")

File.write("config/locales/es.yml", locales)


system("scp -r ~/.keppler/plugins/concerns app/controllers/#{ARGV[0]}")

commons = File.readlines("app/controllers/#{ARGV[0]}/concerns/commons.rb")

commons[0] = "module #{ARGV[0].split('_').map(&:capitalize).join('')}\n"

commons = commons.join("")

File.write("app/controllers/#{ARGV[0]}/concerns/commons.rb", commons)


destroy = File.readlines("app/controllers/#{ARGV[0]}/concerns/destroy_multiple.rb")

destroy[0] = "module #{ARGV[0].split('_').map(&:capitalize).join('')}\n"

destroy = destroy.join("")

File.write("app/controllers/#{ARGV[0]}/concerns/destroy_multiple.rb", destroy)


history = File.readlines("app/controllers/#{ARGV[0]}/concerns/history.rb")

history[0] = "module #{ARGV[0].split('_').map(&:capitalize).join('')}\n"

history = history.join("")

File.write("app/controllers/#{ARGV[0]}/concerns/history.rb", history)

application = File.readlines("app/controllers/#{ARGV[0]}/application_controller.rb")

application[1] = "  class ApplicationController < ::ApplicationController\n"

application = application.join("")

File.write("app/controllers/#{ARGV[0]}/application_controller.rb", application)

dummy_test = File.readlines("test/dummy/config/database.yml")

dummy_test[7] = "  adapter: postgresql\n"
dummy_test = dummy_test.join("")

File.write("test/dummy/config/database.yml", dummy_test)

generator_routes = File.readlines('lib/generators/keppler_scaffold/keppler_scaffold_generator.rb')

generator_routes[37] = "          after: 'scope :#{ARGV[0].split('_').drop(1).join('')}, as: :#{ARGV[0].split('_').drop(1).join('')} do'\n"
generator_routes = generator_routes.join("")

File.write('lib/generators/keppler_scaffold/keppler_scaffold_generator.rb', generator_routes)



layouts = File.readlines("app/views/#{ARGV[0]}/admin/layouts/application.html.haml")

layouts[8] ="        = render '#{ARGV[0]}/admin/layouts/navigation'\n"

layouts = layouts.join("")

File.write("app/views/#{ARGV[0]}/admin/layouts/application.html.haml", layouts)



layouts = File.readlines("app/views/#{ARGV[0]}/admin/layouts/_navigation.html.haml")

layouts[13] ="          = search_form_for [:admin, :#{ARGV[0].split('_').drop(1).join('')}, @q], html: { method: :get } do |f|\n"

layouts = layouts.join("")

File.write("app/views/#{ARGV[0]}/admin/layouts/_navigation.html.haml", layouts)
