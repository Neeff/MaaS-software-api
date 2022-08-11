json.extract! available_hour, :description, :start_hour, :end_hour, :date, :week, :id
json.engineer_available_hours do
  json.array! available_hour.engineer_available_hours, partial: 'available_hours/engineer_available_hour', as: :engineer_available_hour
end
