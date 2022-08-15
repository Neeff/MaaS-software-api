class AvailableHoursController < ApplicationController
  before_action :set_service, only: %i[index update]

  def index
    @available_hours = Availability::Hour.records(@service)
  rescue StandardError => e
    render_rescue(e)
  end

  def update
    @available_hours = Availability::Hour.update(available_hours_params)
    Availability::Shift.new(@service).generate
  rescue StandardError => e
    render_rescue(e)
  end

  private

  def set_service
    @service = Service.find_by(id: params[:service_id])
  end

  def available_hours_params
    params[:available_hours]
  end
end
