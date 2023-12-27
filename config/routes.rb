Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  resource :user, only: [:create]
  resources :book, only: %i[create update destroy show index], controller: 'books'

  resources :book_review, only: %i[create update destroy], controller: 'book_reviews'
  get 'book/:id/reviews' => 'books#book_reviews'

  post 'login' => 'sessions#create'
  get 'auto_login' => 'sessions#auto_login'

  # Defines the root path route ("/")
  # root "posts#index"
end
