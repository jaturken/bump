require 'sinatra'
require 'sinatra/json'

configure do
  set server: ['thin', 'webrick']
end

get '/' do
  'Test API'
end

# TODO:save data to db
post '/bump' do
  sent_data_log = File.open("sent_data.log","a") do |file|
    file.write(params.to_s + "\n")
  end

  json status: 'OK'
end

# returns last 100 lines of log
get '/log' do
  data = []
  File.open("sent_data.log","r").each_line do |line|
    data.unshift line
    data.pop if data.size >= 100
  end
  data.join("<br>")
end

get '*' do
  erb :go_away
end
