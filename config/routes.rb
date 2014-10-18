Rails.application.routes.draw do
  resources :niks

  resources :yaks

  authenticate :user, lambda { |u| u.admin? } do
    mount Upmin::Engine => '/admin'
  end

  root to: 'visitors#index'

  devise_for :users
end
