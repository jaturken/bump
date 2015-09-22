# Run app
require './app'
run Sinatra::Application

# Run Sidekiq admin panel
require 'sidekiq/web'
run Rack::URLMap.new('/' => Sinatra::Application, '/sidekiq' => Sidekiq::Web)
