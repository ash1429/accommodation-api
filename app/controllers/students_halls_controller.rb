# app/controllers/students_halls_controller.rb

class StudentsHallsController < ApplicationController
  before_action :set_students_hall, only: [:show, :update, :destroy]

  # GET /students_halls
  def index
    @students_halls = StudentsHall.all
    json_response(@students_halls)
  end

  # POST /students_halls
  def create
    @students_hall = StudentsHall.create!(students_hall_params)
    json_response(@students_hall, :created)
  end

  # GET /students_halls/:id
  def show
    json_response(@students_hall)
  end

  # PUT /students_halls/:id
  def update
    @students_hall.update(students_hall_params)
    head :no_content
  end

  # DELETE /students_halls/:id
  def destroy
    @students_hall.destroy
    head :no_content
  end

  private

  def students_hall_params
    # whitelist params
    params.permit(:names, :contact_no)
  end

  def set_students_hall
    @students_hall = StudentsHall.find(params[:id])
  end
end