class Api::V1::UsersController < ApplicationController
  def create
    return render json: Error.missing_params, status: :bad_request if missing_params?
    return render json: Error.mismatched_passwords, status: :bad_request if passwords_match?
    return render json: Error.same_email, status: :bad_request if email_in_use?

    render json: UserSerializer.new(User.create(user_params)), status: :created
  end

  private

  def user_params
    JSON.parse(request.body.read, symbolize_names: true)
  end

  def missing_params?
    params[:email].blank? || params[:password].blank? ||
      params[:password_confirmation].blank?
  end

  def passwords_match?
    params[:password] != params[:password_confirmation]
  end

  def email_in_use?
    User.find_by(email: params[:email])
  end
end
