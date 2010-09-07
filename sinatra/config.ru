require 'rubygems'
require 'sinatra'
require 'sass/plugin/rack'
require File.join(File.dirname(__FILE__), 'rivup')
use Sass::Plugin::Rack
run Sinatra::Application