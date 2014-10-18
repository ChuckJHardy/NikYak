module ApplicationHelper
  def user_can_add_yak?(nik)
    current_user != nik.user
  end

  def omniauth_url(provider)
    puts session.inspect

    user_omniauth_authorize_path(
      provider: provider,
      after_sign_up_url: session[:after_sign_up_url]
    )
  end
end
