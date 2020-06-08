class Api::V1::BackgroundsController < ApplicationController
  def index
    render json: BackgroundSerializer.new(BackgroundPhoto.get_city_photo(params[:location]))
  end
end