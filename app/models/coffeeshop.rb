class Coffeeshop < ApplicationRecord
  has_many :employees
  has_many :coffeeshop_coffees
  has_many :coffees, through: :coffeeshop_coffees

  validates :name, :identifier, uniqueness: true

end
