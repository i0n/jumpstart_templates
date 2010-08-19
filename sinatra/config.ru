require 'rubygems'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'PROJECT_NAME') 
require 'sass/plugin/rack'
use Sass::Plugin::Rack
run Sinatra::Application


