json.extract! available_hour, :description, :start_hour, :end_hour, :date, :week, :id
json.shift do
  if available_hour.shift.present?
    json.date available_hour.shift.date
    json.starts_at available_hour.shift.starts_at
    json.ends_at available_hour.shift.ends_at
    json.engineer do
      json.id available_hour.shift.engineer.id
      json.name available_hour.shift.engineer.name
      json.color available_hour.shift.engineer.color
    end
  else
    []
  end
end
