class ItemsController < ApplicationController

	def create
		item = Item.create(
			name: params[:name],
			qty: params[:qty],
			purchased: params[:purchased],
			expiration: params[:expiration],
			note: params[:note],
			location_id: params[:location_id],
			category_id: params[:category_id]
		)

		serialize_data(item)
	end

	def update
		item = Item.find(params[:id])
			item.name = params[:name] if params[:name]
			item.qty = params[:qty] if params[:qty]
			item.purchased = params[:purchased] if params[:purchased]
			item.expiration = params[:expiration] if params[:expiration]
			item.note = params[:note] if params[:note]
			item.location_id = params[:location_id] if params[:location_id]
			item.category_id = params[:category_id] if params[:category_id]
		item.save

		serialize_data(item)
	end

	def destroy
		item = Item.find(params[:id])
		item.destroy

		render json: :accepted
	end

	private

	def serialize_data(data)
		render json: data.to_json(
			include: [ :category, :location ],
			except: [ :created_at, :updated_at, :category_id ]
		)
	end
end
