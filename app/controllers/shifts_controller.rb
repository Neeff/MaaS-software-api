class ShiftsController < ApplicationController
  before_action :set_service
  def index
    @available_hours = Availability::Hour.shifts(service)
  rescue StandardError => e
    render_rescue(e)
  end

  def update
    @available_hour = Availability::Hour.update(shift_params)
    Availability::Shift.new(service).generate
  rescue StandardError => e
    render_rescue(e)
  end

  private

  def set_service
    @service = Service.find_by(id: params[:service_id])
  end

  def shift_params
    params.require(:shift).permit(AvailableHour.allowed_parameters)
  end
end
