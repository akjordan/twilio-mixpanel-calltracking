$:.unshift File.dirname(__FILE__)

require 'bundler'
Bundler.require

log = File.new("logs/sinatra.log", "a+")
$stdout.reopen(log)

require 'app/app.rb'
run Sinatra::Application