module Availability
  class Shift
    def initialize(service)
      @service = service
    end

    def generate
      structure = assignments_hours
      structure.map! { |data| data[:shift_structure] }
      ::Shift.generate_shifts(structure)
    end

    private

    attr_accessor :service

    def assignments_hours
      scheduler = ORTools::BasicScheduler.new(people: engineer_availability,
                                              shifts: shifts,
                                              maximum_hours_to_work: 8)
      scheduler.assignments
    end

    def engineer_availability
      Engineer.available_hours_by_service(service).map do |engineer|
        { availability: engineer.available_hours_struct,
          engineer_id: engineer.id,
          max_hours: average_hours }
      end
    end

    def shifts
      available_hours.map do |available_hour|
        starts_at = available_hour.date.to_time.change({ hour: available_hour.description.split('-').map(&:to_i).first })
        ends_at = available_hour.date.to_time.change({ hour: available_hour.description.split('-').map(&:to_i).second })
        { starts_at: starts_at, ends_at: ends_at, available_hour_id: available_hour.id }
      end
    end

    def available_hours
      AvailableHour.available_hours_by_service(service)
    end

    def average_hours
      (available_hours.size / number_of_engineers).round + 1
    end

    def number_of_engineers
      Engineer.count_by_service(service)
    end
  end
end
