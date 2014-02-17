$:.unshift File.dirname(__FILE__)

require 'bundler'
Bundler.require

require 'app/app.rb'
run Sinatra::Application