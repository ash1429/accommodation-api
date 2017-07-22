# app/controllers/accommodations_controller.rb
class AccommodationsController < ApplicationController
  before_action :set_accommodation, only: [:show, :update, :destroy]

  # GET /accommodations
  def index
    @accommodations = Accommodation.all
    json_response(@accommodations)
  end

  # POST /accommodations
  def create
    @accommodation = Accommodation.create!(accommodation_params)
    json_response(@accommodation, :created)
  end

  # GET /accommodations/:id
  def show
    json_response(@accommodation)
  end

  # PUT /accommodations/:id
  def update
    @accommodation.update(accommodation_params)
    head :no_content
  end

  # DELETE /accommodations/:id
  def destroy
    @accommodation.destroy
    head :no_content
  end

  private

  def accommodation_params
    # whitelist params
    params.permit(:typo)
  end

  def set_accommodation
    @accommodation = Accommodation.find(params[:id])
  end
end
