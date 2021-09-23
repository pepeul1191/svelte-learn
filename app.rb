require 'sinatra'

CONSTANTS = {
  :local => {
    :base_url => 'http://localhost:9292/',
    :static_url => 'http://localhost:9292/',
    :static_env => 'dev',
  },
}

configure do
  enable :sessions
  set :session_secret, 'a33ac20e2af6b865a35b005c6c8df10e'
  set :constants, CONSTANTS[:local]
end

before do
  headers['server'] = 'Ruby, Ubuntu'
end

