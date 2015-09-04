require 'sinatra'
require 'sinatra/json'
require './db.rb'
require './models.rb'
require './lib/bump_processor.rb'
require 'pry'

configure do
  set server: ['thin', 'webrick']
end

get '/' do
  json api: '0.1'
end

post '/bump' do
  BumpProcessor.process_request(request)
  status 200
end

# returns last 10 lines of log
get '/log' do
  data = []
  File.open("sent_data.log","r").each_line do |line|
    data.unshift line
    data.pop if data.size >= 10
  end
  data.join("<br>")
end

get '*' do
  erb :go_away
end
