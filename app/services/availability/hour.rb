module Availability
  class Hour
    attr_accessor :service, :week

    def self.records(service, week)
      new(service, week).records
    end

    def self.shifts(service, week)
      new(service, week).shifts
    end

    def self.update(attrs)
      EngineerAvailableHour.update_time_availability(attrs)
    end

    def initialize(service, week)
      @service = service
      @week = week.presence || Time.now.strftime('%U').to_i
    end

    def records
      AvailableHour.records_by_service(service, week)
    end

    def shifts
      AvailableHour.available_hours_shifts_by_service(service, week)
    end
  end
end
