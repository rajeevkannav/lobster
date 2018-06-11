class Product < ApplicationRecord

  # Validations
  validates :name, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }

  # Associations
  has_many :stockpiles, inverse_of: :product, dependent: :destroy
  has_many :warehouses, through: :stockpiles
end
