Rails.application.routes.draw do
  root 'home#index'

  resources :users do
    member do
      get 'profile'
      get 'matches'
    end
  end

  get 'auth/facebook/callback' => 'sessions#create'
  delete 'sign_out' => 'sessions#destroy'

  post 'create_friendship' => 'friendships#create'
  delete 'delete_friendship' => 'friendships#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
