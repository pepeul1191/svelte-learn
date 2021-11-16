class DentistController < ApplicationController
  get '/dentist/list' do
    resp = nil
    status = 200
    begin
      name = params[:name]
      cop = params[:cop]
      rne = params[:rne]
      query = Dentist.select(:id, :name, :cop, :rne)
      if name != nil
        query = query.where(
					Sequel.like(:name, '%' + name + '%')
				)
      end
      if cop != nil
        query = query.where(
					Sequel.like(:cop, '%' + cop + '%')
				)
      end
      if rne != nil
        query = query.where(
					Sequel.like(:rne, '%' + rne + '%')
				)
      end
      resp = query.to_a.to_json
    rescue Exception => e
      resp = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar los dentistas',
          e.message
        ]
      }.to_json
      status = 500
    end
    status status
    resp
  end

  post '/dentist/save' do
    resp = nil
    status = 200
    payload = JSON.parse(request.body.read)
    deletes = payload['deletes']
    resp = []
    array_news = []
    error = false
    execption = nil
    DB.transaction do
      begin
        if deletes.length != 0
          deletes.each do |d|
            Dentist.where(
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
      resp = ['Se ha registrado los cambios en los dentistas',array_news].to_json
    else
      status = 500
      resp = [
        'Se ha producido un error en guardar la tabla de dentistas',
        execption.message].to_json
    end
    status status
    resp
  end
end