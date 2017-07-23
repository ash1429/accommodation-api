# spec/requests/students_halls_spec.rb
require 'rails_helper'

RSpec.describe 'StudentsHalls API', type: :request do
  # initialize test data 
  let!(:students_halls) { create_list(:students_hall, 10) }
  let(:students_hall_id) { students_halls.first.id }

  # Test suite for GET /students_halls
  describe 'GET /students_halls' do
    # make HTTP get request before each example
    before { get '/students_halls' }

    it 'returns students_halls' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /students_halls/:id
  describe 'GET /students_halls/:id' do
    before { get "/students_halls/#{students_hall_id}" }

    context 'when the record exists' do
      it 'returns the students_hall' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(students_hall_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:students_hall_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find StudentsHall/)
      end
    end
  end

  # Test suite for POST /students_halls
  describe 'POST /students_halls' do
    # valid payload
    let(:valid_attributes) { { names: 'Learn Elm', contact_no: '1' } }

    context 'when the request is valid' do
      before { post '/students_halls', params: valid_attributes }

      it 'creates a students_hall' do
        expect(json['names']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/students_halls', params: { names: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Contact no can't be blank/)
      end
    end
  end

  # Test suite for PUT /students_halls/:id
  describe 'PUT /students_halls/:id' do
    let(:valid_attributes) { { names: 'Shopping' } }

    context 'when the record exists' do
      before { put "/students_halls/#{students_hall_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /students_halls/:id
  describe 'DELETE /students_halls/:id' do
    before { delete "/students_halls/#{students_hall_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end