Rails.application.routes.draw do
  resources :tokens, only: [:new, :create]
  resources :posts, only: [:new, :create]

  root to: 'posts#new', via: :get
  get 'auth/facebook', as: 'auth_provider'
  get 'auth/facebook/callback', to: 'tokens#create'
  get 'posts/get_news'
  post 'posts/get_news'

end
