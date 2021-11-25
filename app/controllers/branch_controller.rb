class BranchController < ApplicationController
	get '/branch/search' do
		resp = nil
		status = 200
		begin
			list = VWBranchType.select(:id, :name).where(
					Sequel.like(:name, '%' + params[:name] + '%')
				).limit(10).to_a
			resp = []
			list.each do |e|
				resp.push({
					:id => e.id,
					:branch_name => e.name,
				})
			end
			resp = resp.to_json
		rescue Exception => e
			resp = [
					'Se ha producido un error en buscar coincidencias en los nombres de los sedes',
					e.message
				].to_json
			status = 500
		end
		status status
		resp
	end

	get '/branch/list_by_type' do
		resp = nil
		status = 200
		branch_type_id = params[:branch_type_id]
		begin
			resp = Branch.select(:id, :name, :address).where(
					:branch_type_id => branch_type_id
				).to_a.to_json
		rescue Exception => e
			branch_type = ['Lima', 'Provincia']
			resp = [
					'Se ha producido un error en buscar las sedes de #{branch_type[branch_type_id]} ',
					e.message
				].to_json
			status = 500
		end
		status status
		resp
	end
end