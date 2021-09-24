require 'sinatra'

CONSTANTS = {
  :local => {
    :base_url => 'http://localhost:9292/',
    :static_url => 'http://localhost:9292/',
    :static_env => 'dev',
  },
}

def random_string_number(len)
  o = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
  (0...len).map { o[rand(o.length)] }.join
end

configure do
  enable :sessions
  set :session_secret, 'a33ac20e2af6b865a35b005c6c8df10e'
  set :constants, CONSTANTS[:local]
end

before do
  headers['server'] = 'Ruby, Ubuntu'
end


['/login', '/login/sign-in', '/login/reset-password'].each do |path|
  get path do
    locals = {}
    erb :'login', :locals => locals
  end
end

get '/' do
  locals = {}
  erb :'home', :locals => locals
end

post '/upload' do
  status = 200
  resp = ''
  file = params[:file]
  puts file
  if file[:type] == 'application/pdf'
    extension = file[:filename].split('.').last
    new_name = random_string_number(30) + '.' + extension # Helper
    tmp = file[:tempfile].path
    FileUtils.mv(tmp, 'public/upload/' + new_name)
    resp = 'upload/' + new_name
  else
    resp = 'formato del archivo no es un PDF'
    status = 500
  end
  status status
  resp
end