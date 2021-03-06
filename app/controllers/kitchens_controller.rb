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
				# locations: {
				# 	except: [ :kitchen_id, :created_at, :updated_at ],
				# 	#include: [ :items ]
				# },
				# categories: {
				# 	except: [ :kitchen_id, :created_at, :updated_at ],
				# 	#include: [ :items ]
				# },
				stocked_items: { 
					except: [ :created_at, :updated_at, :category_id, :location_id ],
					include: [ :category, :location ]
				},
			]
		)
	end
end
