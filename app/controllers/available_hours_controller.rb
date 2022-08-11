class AvailableHoursController < ApplicationController
  before_action :set_service, only: %i[index update]

  def index
    @available_hours = Availability::Hour.records(@service)
    render 'index.json.jbuilder'
  end

  def update
    @available_hour = Availability::Hour.update(available_hour_params)
    render 'update.json.jbuilder'
  end

  private

  def set_service
    @service = Service.find_by(params[:service_id])
  end

  def available_hour_params
    params.require(:available_hour).permit(AvailableHour.allowed_parameters)
  end
end
