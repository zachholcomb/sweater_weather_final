# README
This is the final project for the third module Turing School of Software and Design.

This project consists of a ruby on rails API framework that uses Google Maps API and Open Weather API to construct road trip data including the forecast for the road trip, a background image of the destination city, the travel time, and the projected weather at the time of arrival at a destination.

In this project I focused on applying abstraction and encapsulation to the rails architecture by using services, poros, and serializers, via FastJson.

# Setup

To run this locally fork and clone.

Run `bundle install`

And then `bundle exec figaro install`

You'll need a google maps api key and an open weather map api key

Add these keys in your application.yml file as `GOOGLE_MAPS_API_KEY` and `WEATHER_API_KEY`

