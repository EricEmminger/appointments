# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
csv_text = File.read('db/appt_data.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  format = '%m/%d/%y %k:%M'
  hash = row.to_hash
  hash[:start_time] = DateTime.strptime(row[0], format)
  hash[:end_time] = DateTime.strptime(row[1], format)
  a = Appointment.new(hash)
  a.imported = true
  a.save
end
