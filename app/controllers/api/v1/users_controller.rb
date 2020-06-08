class Api::V1::UsersController < ApplicationController
  def create
    return render json: Error.missing_params, status: 400 if missing_params?
    return render json: Error.mismatched_passwords, status: 400 if passwords_match?
    return render json: Error.same_email, status: 400 if email_in_use?
    render json: UserSerializer.new(User.create(user_params)), status: 201
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def input_params
    params.slice(:email, :password, :password_confirmation)
  end

  def missing_params?
    params[:email].nil? || params[:email].empty? || params[:password].nil? ||
    params[:password].empty? || params[:password_confirmation].nil? ||
    params[:password_confirmation].empty?
  end

  def passwords_match?
    !(params[:password] == params[:password_confirmation])
  end

  def email_in_use?
    User.find_by(email: params[:email])
  end
end