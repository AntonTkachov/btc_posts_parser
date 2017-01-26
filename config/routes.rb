Rails.application.routes.draw do
  resources :tokens, only: [:new, :create]
  resources :posts, only: [:new, :create]

  root to: 'tokens#new', via: :get
  get 'auth/facebook', as: 'auth_provider'
  get 'auth/facebook/callback', to: 'tokens#create'

end
