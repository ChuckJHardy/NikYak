Rails.application.routes.draw do
  resources :niks do
    patch :upvote, on: :member
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Upmin::Engine => '/admin'
  end

  root to: 'visitors#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
