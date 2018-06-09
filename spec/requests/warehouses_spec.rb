require 'rails_helper'

RSpec.describe 'WareHouse API', type: :request do

  # initialize test data
  let!(:warehouses) {create_list(:warehouse, 2)}
  let(:warehouse_id) {warehoues.first.id}

  # Test suite for GET /warehouses
  describe 'GET /warehouses' do
    before { get '/warehouses'}

    it 'returns warehouses' do
      expect(json(response)).not_to be_empty
      expect(json(response).size).to eql(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end
end