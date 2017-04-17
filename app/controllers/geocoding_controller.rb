require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    fortracking= @street_address.strip.gsub(/[^a-z0-9\s]/i, "+").gsub(" ","+")
    url="http://maps.googleapis.com/maps/api/geocode/json?address="+fortracking+"&"
    parsed_data = JSON.parse(open(url).read)
@latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
@longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================





    render("geocoding/street_to_coords.html.erb")
  end
end
