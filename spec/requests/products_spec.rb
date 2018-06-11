require 'rails_helper'

RSpec.describe 'Products API', type: :request do

  # initialize test data
  let!(:products) {create_list(:product, 10)}
  let(:product_id) {products.first.id}

  # Test suite for GET /products
  describe 'GET /products' do
    # make http get request before each example
    before { get '/products'}

    it 'returns products' do
      expect(json(response)).not_to be_empty
      expect(json(response).size).to eql(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /products/:id
  describe 'GET /products/:id' do
    before { get "/products/#{product_id}"}

    context 'when the product exists' do
      it 'returns the product' do
        expect(json(response)).not_to be_empty
        expect(json(response)['id']).to eql(product_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the product not exists' do
      let(:product_id) {100}

      it 'returns the status code 404' do
        expect(response).to have_http_status(404)
      end

    end

  end

  #Test suite for POST /products
  describe 'POST /products' do
    let(:valid_attributes) { {name: 'Product First', price: 10.35}}

    context 'when the requests is valid' do
      before {post '/products', params: valid_attributes}

      it 'creates a product' do
        expect(json(response)['name']).to eq('Product First')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(201)
      end

    end

    context 'when the request is not valid' do
      before {post '/products', params: {name: ''}}
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end


    # Test suite for PUT products/:id
    describe 'PUT /products/:id' do
      let(:valid_attributes) { {name: 'Product first update' }}

      context 'when the product exists' do
        before { put "/products/#{product_id}", params: valid_attributes }
        it 'updates the product' do
            expect(response.body).to be_empty
        end

        it 'returns the status code 204' do
          expect(response).to have_http_status(204)
        end
      end
    end

    # Test Suite for Delete products/:id
    describe 'Delete products/:id' do
      before { delete "/products/#{product_id}"}
      it 'returns the status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

end