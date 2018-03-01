class PostcodesController < ApplicationController
  def index
    postcodes = Array.wrap(Australia::Postcode.find(params[:postcode]))
    return head(:not_found) if postcodes.empty?
    postcode = postcodes.first

    postcodes_by_distance = {}
    [3, 7, 10, 20].each do |km_distance|
      postcodes_by_distance[km_distance] =
        postcodes_nearby(postcode: postcode, distance: km_distance)
    end

    render json: postcodes_by_distance
  end

  private

  def postcodes_nearby(postcode:, distance:)
    postcode
      .nearby(distance: distance)
      .map(&:postcode)
      .sort
      .uniq
  end
end
