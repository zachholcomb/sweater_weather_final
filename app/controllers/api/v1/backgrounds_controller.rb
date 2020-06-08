class Api::V1::BackgroundsController < ApplicationController
  def index
    render json: BackgroundImageSerializer.new(BackgroundPhoto.get_city_photo(params[:location]))
  end
end