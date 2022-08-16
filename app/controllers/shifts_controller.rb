class ShiftsController < ApplicationController
  before_action :set_service, only: %i[index]
  before_action :set_week, only: %i[index]
  def index
    @available_hours = Availability::Hour.shifts(@service, @week)
  rescue StandardError => e
    render_rescue(e)
  end

  private

  def set_service
    @service = Service.find_by(id: params[:service_id])
  end

  def set_week
    @week = params[:week]
  end
end
