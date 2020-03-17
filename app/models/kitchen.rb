class Kitchen < ApplicationRecord
	has_many :locations

	def stocked_items
		items = []
		## for each location
		self.locations.each do |location|
			## add that locations items to the list
			location.items.map do |item| 
				items << item
			end
		end
		items
	end
end
