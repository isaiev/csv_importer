class Employee < ApplicationRecord
  belongs_to :coffeeshop

  validates :identifier, format: { with: /(STAFF|EMP)\d+/ }
end
