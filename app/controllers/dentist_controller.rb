class DentistController < ApplicationController
  get '/dentist/list' do
    resp = nil
    status = 200
    begin
      name = params[:name]
      cop = params[:cop]
      rne = params[:rne]
      page = params[:page]
      step = params[:step]
      query = Dentist.select(:id, :name, :cop, :rne)
      # wheres
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
      # pagination
      if (page != nil and step != nil)
        count = query.count
        offset = (page.to_i - 1) * step.to_i
        query = query.offset(offset).limit(step)
        # do query
        #resp[:data] = query.to_a
        resp = {
          :list => query.to_a,
          :pages => (count * 1.0 / step.to_i).ceil()
        }.to_json
      else
        # do query
        resp = query.to_a.to_json
      end
    rescue Exception => e
      puts e.backtrace
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