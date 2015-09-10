Airbrake.configure do |config|
  config.api_key = '6d1c98c40185e1c30515b24cbd500d3c'
  config.host    = 'jaturken.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end
