class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    return render json: Error.no_user, status: 400 if user.nil?
    return render json: Error.password, status: 400 if check_password(user)
    render json: UserSerializer.new(user)
  end

  private

  def check_password(user)
    !(user.authenticate(params[:password]))
  end
end