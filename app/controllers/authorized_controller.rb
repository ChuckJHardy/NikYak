class AuthorizedController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    if request.fullpath == new_nik_path
      session[:after_sign_up_url] = request.fullpath
    end

    authenticate_user!
  end
end
