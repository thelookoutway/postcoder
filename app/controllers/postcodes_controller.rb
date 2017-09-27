class PostcodesController < ApplicationController
  def index
    postcodes = Australia::Postcode.find(params["postcode"])
    return head(:not_found) unless postcodes.present?
    @postcode = postcodes.first

    results = {}
    [3, 7, 10, 20].each do |radius|
      results[radius] = surrounding_suburbs(radius)
    end

    render json: results
  end

  def surrounding_suburbs(radius)
    @postcode
      .nearby(distance: radius)
      .map(&:postcode).uniq
  end
end
