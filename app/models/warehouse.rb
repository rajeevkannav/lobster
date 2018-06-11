class Warehouse < ApplicationRecord

  # Validates
  validates :name, presence: true

  # Associations
  has_many :stockpiles, inverse_of: :warehouse, dependent: :destroy
  has_many :products, through: :stockpiles

end
