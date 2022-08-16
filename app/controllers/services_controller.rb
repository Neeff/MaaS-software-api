class ServicesController < ApplicationController
  before_action :set_services, only: :index
  before_action :set_service, only: :destroy

  def index; end

  def create
    @service = Service.create(service_params)
    Availability::Template.massive(today, five_weeks_to_future, @service.contract)
  rescue StandardError => e
    render_rescue(e)
  end

  def destroy
    @service.destroy
    render json: { success: true }, status: :ok
  rescue StandardError => e
    render_rescue(e)
  end

  private

  def set_services
    @services = Service.all
  end

  def set_service
    @service = Service.find_by(id: params[:id])
  end

  def service_params
    params.require(:service).permit(Service.allowed_parameters)
  end

  def today
    Date.today.beginning_of_week
  end

  def five_weeks_to_future
    today + 5.week
  end
end
