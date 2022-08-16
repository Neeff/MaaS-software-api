module Availability
  class Template

    def self.massive(today, five_weeks_to_future, contract)
      (today..five_weeks_to_future).to_a.select(&:monday?).each do |date|
        generate(contract, date)
      end
    end

    def self.generate(contract, date)
      new(contract, date).by_week
    end

    def initialize(contract, date)
      @date = date
      @start_week = date.beginning_of_week
      @end_week = date.end_of_week
      @contract = contract
    end

    def by_week
      associate
    end

    private

    attr_accessor :contract, :date, :start_week, :end_week

    def service
      Service.find_by(id: contract.service_id)
    end

    def associate
      structure = make_structure_by_day
      AvailableHour.generate_available_hours(structure)
      EngineerAvailableHour.generate_intemediate_relation(service, week)
    end

    def active_days
      contract.business_days.select { |_key, value| value }.keys
    end

    def weekend?(day)
      day.sunday? || day.saturday?
    end

    def days
      active_days.map { |day| hash_days[day] }.compact
    end

    def hash_days
      hash_days = Hash.new(:UNPROCESSABLE)
      (start_week..end_week).to_a.map { |day| hash_days[day.strftime('%A').downcase] = day }
      hash_days
    end

    def return_valid_time(hour)
      hour = hour.eql?(0) ? 24 : hour
      DateTime.now.change({ hour: hour }).to_time
    end

    def init_hour
      return_valid_time(contract.init_hour)
    end

    def finish_hour
      return_valid_time(contract.finish_hour)
    end

    def init_weekend_hour
      return_valid_time(contract.init_weekend_hour)
    end

    def finish_weekend_hour
      return_valid_time(contract.finish_weekend_hour)
    end

    def hours
      ((finish_hour - init_hour) / 1.hour).round
    end

    def weekend_hours
      ((finish_weekend_hour - init_weekend_hour) / 1.hour).round
    end

    def week
      date.to_time.strftime('%U').to_i
    end

    def make_structure(hours, day, start_hour, end_hour)
      data = []
      hour = start_hour.hour
      hours.times do
        description = "#{hour}:00-#{hour + 1}:00"
        data << { date: day,
                  service_id: contract.service_id,
                  description: description,
                  start_hour: start_hour.hour,
                  end_hour: end_hour.hour,
                  week: week }
        hour += 1
      end
      data
    end

    def make_structure_by_day
      structure = days.map do |day|
        if weekend?(day)
          make_structure(weekend_hours, day, init_weekend_hour, finish_weekend_hour)
        else
          make_structure(hours, day, init_hour, finish_hour)
        end
      end
      structure.flatten
    end
  end
end
