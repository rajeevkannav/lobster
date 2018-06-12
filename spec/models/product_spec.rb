require 'rails_helper'

RSpec.describe Product, type: :model do

  # Validation Tests
  # ensure column name and price are present before saving
  describe '#name' do
    it { should validate_presence_of(:name) }
  end

  describe '#price' do
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_less_than(1000000).is_greater_than(0) }
  end
end
