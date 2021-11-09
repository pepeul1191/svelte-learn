require 'sinatra'
require 'json'
require 'sequel'

Sequel::Model.plugin :json_serializer
DB = Sequel.connect('sqlite://db/data.db')

class District < Sequel::Model(DB[:districts])

end

class Department < Sequel::Model(DB[:departments])

end

class VWDistrict < Sequel::Model(DB[:vw_districts])

end


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

['/', '/department/add'].each do |path|
  get path do
    locals = {}
    erb :'home', :locals => locals
  end
end

post '/upload' do
  status = 200
  resp = ''
  file = params[:file]
  # puts file
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

get '/district/search' do
  resp = nil
  status = 200
  begin
    list = VWDistrict.where(
        Sequel.like(:name, '%' + params[:name] + '%')
      ).limit(10).to_a
    resp = []
    list.each do |e|
      resp.push({
        :id => e.id,
        :name => e.name,
      })
    end
    resp = resp.to_json
  rescue Exception => e
    resp = {
      :tipo_mensaje => 'error',
      :mensaje => [
        'Se ha producido un error en buscar coincidencias en los nombres de los distritos',
        e.message
      ]
    }.to_json
    status = 500
  end
  status status
  resp
end

post '/department/save' do
  resp = nil
  status = 200
  payload = JSON.parse(request.body.read)
  news = payload['news']
  edits = payload['edits']
  deletes = payload['deletes']
  resp = []
  array_news = []
  error = false
  execption = nil
  DB.transaction do
    begin
      if news.length != 0
        news.each do |n|
          tmp = Department.new(
            :name => n['name']
          )
          tmp.save
          t = {
            :tmp => n['id'],
            :id => tmp.id
          }
          array_news.push(t)
        end
      end
      if edits.length != 0
        edits.each do |e|
          tmp = Department.where(
            :id => e['id']
          ).first
          tmp.name = e['name']
          tmp.save
        end
      end
      if deletes.length != 0
        deletes.each do |d|
          Department.where(
            :id => d['id']
        ).delete
        end
      end
    rescue Exception => e
      Sequel::Rollback
      error = true
      execption = e
    end
  end
  if error == false
    resp = ['Se ha registrado los cambios en los departamentos',array_news].to_json
  else
    status = 500
    resp = [
      'Se ha producido un error en guardar la tabla de departamentos',
      execption.message].to_json
  end
  status status
  resp
end

get '/department/search' do
  resp = nil
  status = 200
  begin
    list = Department.where(
        Sequel.like(:name, '%' + params[:name] + '%')
      ).limit(10).to_a
    resp = []
    list.each do |e|
      resp.push({
        :id => e.id,
        :name => e.name,
      })
    end
    resp = resp.to_json
  rescue Exception => e
    resp = {
      :tipo_mensaje => 'error',
      :mensaje => [
        'Se ha producido un error en buscar coincidencias en los nombres de los departamentos',
        e.message
      ]
    }.to_json
    status = 500
  end
  status status
  resp
end

get '/department/list' do
  resp = nil
  status = 200
  begin
    resp = Department.all().to_a.to_json
  rescue Exception => e
    resp = {
      :tipo_mensaje => 'error',
      :mensaje => [
        'Se ha producido un error en listar los departamentos',
        e.message
      ]
    }.to_json
    status = 500
  end
  status status
  resp
end
