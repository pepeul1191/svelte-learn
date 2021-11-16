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

  get '/dentist/specialism/list' do
    resp = nil
    status = 200
    begin
      dentist_id = params[:dentist_id]
      resp = DB.fetch(''' 
        SELECT T.id AS id, T.name AS name, (CASE WHEN (P.exist = 1) THEN 1 ELSE 0 END) AS exist FROM
        (
          SELECT id, name, 0 AS exist FROM specialisms
        ) T 
        LEFT JOIN 
        (
          SELECT C.id, C.name, 1 AS exist FROM 
          specialisms C INNER JOIN dentists_specialisms TC ON
          C.id = TC.specialism_id
          WHERE TC.dentist_id = ?
        ) P 
        ON P.id = T.id
      ''', dentist_id).to_a.to_json
    rescue Exception => e
      puts e.backtrace
      resp = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error en listar las especialidades del dentista',
          e.message
        ]
      }.to_json
      status = 500
    end
    status status
    resp
  end

  post '/dentist/specialism/save' do
    resp = nil
		status = 200
		payload = JSON.parse(request.body.read)
		edits = payload['edits']
		dentist_id = payload['extra']['dentist_id']
		resp = []
		array_news = []
		error = false
		execption = nil
		DB.transaction do
			begin
				if edits.length != 0
					edits.each do |e|
						tmp = DentistSpecialism.where(
							:specialism_id => e['id'],
              :dentist_id => dentist_id
						).first
						if e['exist'] == 0
              if tmp != nil
                tmp.delete
              end
            else
              if tmp == nil
                tmp = DentistSpecialism.new(
                  :specialism_id => e['id'],
                  :dentist_id => dentist_id
                )
                tmp.save
              end
            end
					end
				end
			rescue Exception => e
				Sequel::Rollback
				error = true
				execption = e
			end
		end
		if error == false
			resp = ['Se ha asosiado las especialidades al dentista'].to_json
		else
			status = 500
			resp = [
				'Se ha producido un error en asosiar las especialidades al dentista',
				execption.message].to_json
		end
		status status
		resp
	end
end