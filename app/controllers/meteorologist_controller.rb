require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    fortracking= @street_address.strip.gsub(/[^a-z0-9\s]/i, "+").gsub(" ","+")
    url="http://maps.googleapis.com/maps/api/geocode/json?address="+fortracking+"&"
    parsed_data = JSON.parse(open(url).read)
    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]
    newfortracking=@lat.to_s+","+@lng.to_s
    newurl="https://api.darksky.net/forecast/441c8b435b6182933ccb43866d984467/"+newfortracking
    newparsed_data = JSON.parse(open(newurl).read)

    @current_temperature = newparsed_data["currently"]["temperature"]

    @current_summary = newparsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = newparsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = newparsed_data["hourly"]["summary"]

    @summary_of_next_several_days = newparsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
