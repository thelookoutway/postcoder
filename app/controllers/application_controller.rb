class ApplicationController < ActionController::API
  before_action :is_authorized?

  def is_authorized?
    head :unauthorized unless params[:api_token] == ENV["API_TOKEN"]
  end
end
