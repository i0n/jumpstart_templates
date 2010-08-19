##################### Setup

require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'dm-core'
require 'dm-migrations'

# Setup Datamapper connection to Sqlite3 database
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/log/rivup.db")

# Sets the root path for the app. REQUIRED!
set :root, File.dirname(__FILE__)

# Sets up the public folder
set :public, 'public'

configure :production do
  set :sass, {:style => :compressed }
  set :haml, {:ugly => true}
end

##################### DataMapper

class ClickTracker
  include DataMapper::Resource
  property :id, Serial
  property :counter, Integer, :default => 0
end

# Create/Upgrade/Migrate database automatically
DataMapper.auto_upgrade!

##################### Sass

get '/stylesheets/global.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :"sass/global"
end

get '/stylesheets/ie.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :"sass/ie"
end

get '/stylesheets/handheld.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :"sass/handheld"
end

get '/stylesheets/print.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :"sass/print"
end

get '/stylesheets/screen.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :"sass/screen"
end

##################### Main Routes

before  do
  headers 'Content-Type' => 'text/html; charset=utf-8'
end

get '/' do
  @title = ""
  haml :index
end
