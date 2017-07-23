# spec/requests/notices_spec.rb

require 'rails_helper'

RSpec.describe 'Notices API', type: :request do
  # initialize test data 
  let!(:notices) { create_list(:notice, 10) }
  let(:notice_id) { notices.first.id }

  # Test suite for GET /notices
  describe 'GET /notices' do
    # make HTTP get request before each example
    before { get '/notices' }

    it 'returns notices' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /notices/:id
  describe 'GET /notices/:id' do
    before { get "/notices/#{notice_id}" }

    context 'when the record exists' do
      it 'returns the notice' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(notice_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:notice_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Notice/)
      end
    end
  end


 describe 'POST /notices' do
    # valid payload
    let(:valid_attributes) { { notice_for: 'Habibur Rahman Hall', details: 'Hall Admission', important_dates: 'Starts 8.8.10 Ends 11.11.11', attachments_needed: 'photo, id card' } }

    context 'when the request is valid' do
      before { post '/notices', params: valid_attributes }

      it 'creates a notice' do
        expect(json['notice_for']).to eq('Habibur Rahman Hall')
        expect(json['details']).to eq('Hall Admission')
        expect(json['important_dates']).to eq('Starts 8.8.10 Ends 11.11.11')
        expect(json['attachments_needed']).to eq('photo, id card')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
####################################################################################


    context 'when the request is invalid' do
      before { post '/notices', params: { notice_for: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Details can't be blank, Important dates can't be blank, Attachments needed can't be blank/)
      end
    end
  end




  # Test suite for PUT /notices/:id
  describe 'PUT /notices/:id' do
    let(:valid_attributes) { { notice_for: 'Teachers Quarter' } }

    context 'when the record exists' do
      before { put "/notices/#{notice_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /notices/:id
  describe 'DELETE /notices/:id' do
    before { delete "/notices/#{notice_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end