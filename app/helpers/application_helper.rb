module ApplicationHelper
  def user_can_add_yak?(nik)
    current_user != nik.user
  end

  def omniauth_url(provider, nik_id: nil)
    if nik_id
      session[:after_sign_up_url] = nik_path(id: nik_id)
    end

    user_omniauth_authorize_path(
      provider: provider,
      after_sign_up_url: session[:after_sign_up_url]
    )
  end

  def render_tree(nik, container = "body")
    (<<-JS
      <script type="text/javascript">
        new Tree(#{TreeStructure.structure(nik).to_json}, '#{container}');
      </script>
    JS
    ).html_safe
  end
end
