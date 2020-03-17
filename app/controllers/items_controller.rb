class ItemsController < ApplicationController

	def create
		item = Item.create(
			name: params[:name],
			purchased: params[:purchased],
			expiration: params[:expiration],
			qty: params[:qty],
			note: params[:note],
			location_id: params[:location_id],
			category_id: params[:category_id]
		)

		render json: Kitchen.find(Location.find(params:location_id).kitchen)
	end
end
