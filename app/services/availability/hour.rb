module Availability
  class Hour
    attr_accessor :service

    def self.records(service)
      new(service).records
    end

    def self.shifts(service)
      new(service).shifts
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

    def shifts
      AvailableHour.available_hours_shifts_by_service(service)
    end
  end
end
