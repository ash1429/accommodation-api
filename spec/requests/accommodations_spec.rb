# spec/requests/accommodations_spec.rb
require 'rails_helper'

RSpec.describe 'accommodations API', type: :request do
  # initialize test data 
  let!(:accommodations) { create_list(:accommodation, 10) }
  let(:accommodation_id) { accommodations.first.id }

  # Test suite for GET /accommodations
  describe 'GET /accommodations' do
    # make HTTP get request before each example
    before { get '/accommodations' }

    it 'returns accommodations' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /accommodations/:id
  describe 'GET /accommodations/:id' do
    before { get "/accommodations/#{accommodation_id}" }

    context 'when the record exists' do
      it 'returns the accommodation' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(accommodation_id)
        
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:accommodation_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Accommodation/)
      end
    end
  end

  # Test suite for POST /accommodations
  describe 'POST /accommodations' do
    # valid payload
    let(:valid_attributes) { { typo: 'Learn Elm' } }

    context 'when the request is valid' do
      before { post '/accommodations', params: valid_attributes }

      it 'creates a accommodation' do
        expect(json['typo']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/accommodations', params: { typo: nil } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
       it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Typo can't be blank/)
      end
    end
  end

  # Test suite for PUT /accommodations/:id
  describe 'PUT /accommodations/:id' do
    let(:valid_attributes) { { typo: 'Shopping' } }

    context 'when the record exists' do
      before { put "/accommodations/#{accommodation_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /accommodations/:id
  describe 'DELETE /accommodations/:id' do
    before { delete "/accommodations/#{accommodation_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end