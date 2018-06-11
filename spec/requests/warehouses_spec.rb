require 'rails_helper'

RSpec.describe 'WareHouse API', type: :request do

  # initialize test data
  let!(:warehouses) {create_list(:warehouse, 2)}
  let(:warehouse_id) {warehouses.first.id}

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

  # Test suite for GET /warehouses/:id
  describe 'GET /warehouses/:id' do
    before { get "/warehouses/#{warehouse_id}"}

    context 'when the warehouse exists' do
      it 'returns the warehouse' do
        expect(json(response)).not_to be_empty
        expect(json(response)['id']).to eql(warehouse_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the warehouse not exists' do
      let(:warehouse_id) {100}

      it 'returns the status code 404' do
        expect(response).to have_http_status(404)
      end

    end

  end

  #Test suite for POST /warehouses
  describe 'POST /warehouses' do
    let(:valid_attributes) { {name: 'warehouse First'}}

    context 'when the requests is valid' do
      before {post '/warehouses', params: valid_attributes}

      it 'creates a warehouse' do
        expect(json(response)['name']).to eq('warehouse First')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(201)
      end

    end

    context 'when the request is not valid' do
      before {post '/warehouses', params: {name: ''}}
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end


    # Test suite for PUT warehouses/:id
    describe 'PUT /warehouses/:id' do
      let(:valid_attributes) { {name: 'warehouse first update' }}

      context 'when the warehouse exists' do
        before { put "/warehouses/#{warehouse_id}", params: valid_attributes }
        it 'updates the warehouse' do
          expect(response.body).to be_empty
        end

        it 'returns the status code 204' do
          expect(response).to have_http_status(204)
        end
      end
    end

    # Test Suite for Delete warehouses/:id
    describe 'Delete /warehouses/:id' do
      before { delete "/warehouses/#{warehouse_id}"}
      it 'returns the status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
