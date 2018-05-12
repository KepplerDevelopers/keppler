### keppler Scaffold Engine

Generador scaffold para crear modulos de [keppler Admin](https://github.com/inyxtech/Keppler-Admin)

### Instalación

Copia la carpeta ```generators``` y colocarla en ```lib/```

Colocar la dependencia a haml.

```ruby
s.add_dependency "simple_form"
s.add_dependency "haml_rails"
```

Luego declara el tipo de generado para las vistaen el archivo ```engine.rb``` en ```lib/```

```ruby
config.generators do |g|
  g.template_engine :haml
end
```

Para crea el scaffold solo debe colocar en consola

`rails g keppler_scaffold <module_name> <attributes>`
