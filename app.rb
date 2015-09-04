require 'sinatra'
require 'sinatra/json'
require './db.rb'
require './models.rb'
require './lib/bump_processor.rb'

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

get '/last_bump' do
  bump = Bump.last
  data = ['Last bump:', bump.values.to_s,  "Its socials:"] + bump.socials.map(&:values).map(&:to_s)
  data.join("<br>\n")
end

get '*' do
  erb :go_away
end
