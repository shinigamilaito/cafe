class TypeCoffee < ApplicationRecord
	has_many :partidas
  
  validates :name, presence: true
  validates :name, uniqueness: true
end
