Rails.application.routes.draw do
  resources :niks

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
end
