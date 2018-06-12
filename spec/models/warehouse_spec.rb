require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  # Validation Tests
  # ensure column name is present before saving

  describe '#name' do
    it {should validate_presence_of(:name)}
  end
end
