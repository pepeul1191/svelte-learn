class BranchController < ApplicationController
	get '/branch/search' do
		resp = nil
		status = 200
		begin
			list = VWDentistBranch.where(
					Sequel.like(:branch_name, '%' + params[:name] + '%')
				).group(:branch_name).limit(10).to_a
			resp = []
			list.each do |e|
				resp.push({
					:id => e.id,
					:branch_name => e.branch_name,
				})
			end
			resp = resp.to_json
		rescue Exception => e
			resp = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en buscar coincidencias en los nombres de los sedes',
					e.message
				]
			}.to_json
			status = 500
		end
		status status
		resp
	end
end