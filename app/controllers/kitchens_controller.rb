class KitchensController < ApplicationController

	def index
		kitchens = Kitchen.all
		render json:kitchens
	end

	def show
		kitchen = Kitchen.find(params[:id])
		serialize_data(kitchen)
	end

	private

	def serialize_data(data)
		render json: data.to_json(
			except: [ :created_at, :updated_at],
			include: [
				locations: {
					except: [ :kitchen_id, :created_at, :updated_at ],
					include: [ :items ]
				} 
			]
		)
	end
end
