class LocationsController < ApplicationController

	def index
		locations = Location.all
		render json:locations.to_json(
			except: [ :created_at, :updated_at, :kitchen_id]
		)
	end

end
