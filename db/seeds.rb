# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
conn = ActiveRecord::Base.connection
rc = conn.raw_connection
rc.exec("COPY postcodes(postcode,suburb,state,lat,lng) FROM STDIN WITH CSV HEADER")

file = File.open('db/postcodes.csv', 'r')
while !file.eof?
  # Add row to copy data
  rc.put_copy_data(file.readline)
end

# We are done adding copy data
rc.put_copy_end
rc.exec("UPDATE postcodes SET lonlat = ST_GeomFromText('POINT(' || lng || ' ' || lat || ')');")
#
while res = rc.get_result
  if e_message = res.error_message
    p e_message
  end
end

