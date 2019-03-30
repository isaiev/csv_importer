class Transaction < ApplicationRecord
  belongs_to :coffeeshop
  belongs_to :employee
  belongs_to :coffee

  validates :coffeeshop_id, :employee_id, :coffee_id, :price, :sold_at, presence: true
end
