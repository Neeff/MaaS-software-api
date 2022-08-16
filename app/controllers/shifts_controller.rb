class ShiftsController < ApplicationController
  before_action :set_service, only: %i[index update]
  before_action :set_week, only: %i[index update]
  def index
    @available_hours = Availability::Hour.shifts(@service, @week)
  rescue StandardError => e
    render_rescue(e)
  end

  def update
    @available_hour = Availability::Hour.update(shift_params)
    Availability::Shift.new(@service, @week).generate
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

  def shift_params
    params.require(:shift).permit(AvailableHour.allowed_parameters)
  end
end
