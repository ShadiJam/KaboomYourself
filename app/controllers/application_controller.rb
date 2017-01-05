class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def location
    if params[:location].blank?
      if Rails.env.test? || Rails.env.development?
        @location ||= Geocoder.search("50.78.167.161").first
      else
        @location ||= request.location
      end
    else
      params[:location].each {|l| l = l.to_i } if params[:location].is_a? Array
      @location ||= Geocoder.search(params[:location]).first
      allowed = [:latitude, :longitude, :address, :city]
      puts @location.methods
      @location
    end
  end
end
