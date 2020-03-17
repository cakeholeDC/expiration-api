class Location < ApplicationRecord
  belongs_to :kitchen
  has_many :items
end
