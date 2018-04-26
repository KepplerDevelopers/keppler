#! /bin/bash

function keppler() {
  if [ $1 == 'new' ]
  then    
    PROJECT_NAME=$2
    keppler_new_project
  elif [ $1 == 'help' ]
  then
    echo ""
    echo "Global Comands:"
    echo "-----------------"
    echo "- Keppler new [project_name]"
    echo "- Keppler plugin [plugin_name]"
    echo ""
    echo "Project Comands:"
    echo "-----------------"    
    echo "- Keppler new_module [module_name] [field_name]:[type]"
    echo "- Keppler delete_module [module_name]"
    echo "- Keppler install"
    echo "- Keppler reset"
    echo "- Keppler server"
    echo ""
  elif [ $1 == 'server' ]
  then
    rails s -p 4000
  elif [ $1 == 'install' ]
  then
    bundle install
  elif [ $1 == 'reset' ]
  then
    rake db:drop db:create db:migrate db:seed
  elif [ $1 == 'plugin' ]
  then
    PLUGIN_NAME=$2
    keppler_new_plugin
  elif [ $1 == 'new_module' ]
  then
    ruby ~/.keppler/lib/scaffold.rb $*
    rake db:migrate
  elif [ $1 == 'delete_module' ]
  then
    ruby ~/.keppler/lib/scaffold.rb $*
  else
    echo "[Error] Command $1 no valid"
  fi
}

function keppler_new_project() {
  scp -r ~/.keppler/core $PROJECT_NAME
  cd $PROJECT_NAME
  bundle install
  scp -r ~/.keppler/db_conf/conf.yml config/secrets.yml
  ruby ~/.keppler/lib/conf.rb
  rake db:create db:migrate db:seed
  echo "$PROJECT_NAME has been created"
}

function keppler_new_plugin () {
  echo"$PLUGIN_NAME has been created"
}