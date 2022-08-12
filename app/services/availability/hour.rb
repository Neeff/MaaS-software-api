module Availability
  class Hour
    def self.records(service)
      new(service).records
    end

    def self.update(attrs)
      EngineerAvailableHour.update_time_availability(attrs)
    end

    def initialize(service)
      @service = service
    end

    def records
      AvailableHour.records_by_service(service)
    end

    private

    attr_accessor :service
  end
end
