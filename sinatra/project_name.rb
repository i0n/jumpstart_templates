##################### Setup

require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'dm-core'
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/log/rivup.db")
set :public, 'public'

configure :production do
  set :sass, {:style => :compressed }
  set :haml, {:ugly => true}
end

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
