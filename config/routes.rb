Rails.application.routes.draw do
  resources :niks

  authenticate :user, lambda { |u| u.admin? } do
    mount Upmin::Engine => '/admin'
  end

  root to: 'visitors#index'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" } do
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
end
