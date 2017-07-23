# app/controllers/notices_controller.rb


class NoticesController < ApplicationController

	before_action :set_notice, only: [:show, :update, :destroy]

  # GET /notices
  def index
    @notices = Notice.all
    json_response(@notices)
  end

  # POST /notices
  def create
    @notice = Notice.create!(notice_params)
    json_response(@notice, :created)
  end

  # GET /notices/:id
  def show
    json_response(@notice)
  end

  # PUT /notices/:id
  def update
    @notice.update(notice_params)
    head :no_content
  end

  # DELETE /notices/:id
  def destroy
    @notice.destroy
    head :no_content
  end

  private

  def notice_params
    # whitelist params
    params.permit(:notice_for, :details, :important_dates, :attachments_needed)
  end

  def set_notice
    @notice = Notice.find(params[:id])
  end
end