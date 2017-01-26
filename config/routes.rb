Rails.application.routes.draw do
  root to: 'tokens#new', via: :get
  get 'auth/facebook', as: 'auth_provider'
  get 'auth/facebook/callback', to: 'tokens#create'
end
