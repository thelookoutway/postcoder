class Postcode < ApplicationRecord
  def self.find_in_radius(postcode: , radius:)
    # where("ST_Distance_Sphere(lonlat, (SELECT lonlat FROM postcodes WHERE postcode = ? LIMIT 1)) <=  ?", postcode, radius)
    where("ST_DWithin(lonlat::geography, (SELECT lonlat FROM postcodes WHERE postcode = ? LIMIT 1)::geography, ?)", postcode, radius).pluck(:postcode).uniq
  end
end
