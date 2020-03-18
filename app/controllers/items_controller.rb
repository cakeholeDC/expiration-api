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

		# kitchen = Location.find(params[:location_id]).kitchen
		# serialize_kitchen_data(kitchen)
		render json:item.to_json(
			include: [ :category ],
			except: [ :created_at, :updated_at, :category_id ]
		)
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

		# kitchen = Location.find(item.location.id).kitchen
		# serialize_kitchen_data(kitchen)
		render json:item.to_json(
			include: [ :category ],
			except: [ :created_at, :updated_at, :category_id ]
		)
	end

	def destroy
		item = Item.find(params[:id])
		item.destroy

		render json: :accepted
	end

	private

	def serialize_kitchen_data(data)
		render json: data.to_json(
			except: [ :created_at, :updated_at],
			include: [
				locations: {
					except: [ :kitchen_id, :created_at, :updated_at ],
					include: [ :items ]
				},
				stocked_items: { 
					except: [ :created_at, :updated_at, :category_id ],
					include: [ :category ]
				},
			]
		)
	end
end
