json.total number_with_delimiter(@maintenance_schedules.map{|x| x.read_attribute(:price).nil? ? 0 : x.read_attribute(:price) }.sum)
json.data do
  json.array! @maintenance_schedules do |maintenance_schedule|
    json.id maintenance_schedule.id
    json.vehicle_id maintenance_schedule.vehicle_id
    json.date maintenance_schedule.date
    json.mileage maintenance_schedule.mileage
    json.price maintenance_schedule.price
    json.status maintenance_schedule.status
    json.part maintenance_schedule.part
    json.vehicle maintenance_schedule.vehicle
  end
end
