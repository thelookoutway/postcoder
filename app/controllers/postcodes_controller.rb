class PostcodesController < ApplicationController
  def index
    results = Postcode.find_in_radius(postcode: params["postcode"], radius: params["radius"])
    render plain: results.join(" ")
  end
end
