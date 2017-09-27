class PostcodesController < ApplicationController
  def index
    postcodes = Australia::Postcode.find(params["postcode"])
    return head(:not_found) unless postcodes.present?
    @postcode = postcodes.first

    radius = params["radius"].to_f
    results = {}

    (1..3).each do |multiplier|
      new_radius = radius * multiplier
      results[new_radius] = surrounding_suburbs(new_radius)
    end

    render json: results
  end

  def surrounding_suburbs(radius)
    @postcode
      .nearby(distance: radius)
      .map(&:postcode).uniq
  end
end
