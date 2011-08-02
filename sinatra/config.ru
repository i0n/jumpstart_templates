require 'rubygems'
require 'sinatra'
require 'sass/plugin/rack'
require File.join(File.dirname(__FILE__), 'PROJECT_NAME')
use Sass::Plugin::Rack
run Sinatra::Application
