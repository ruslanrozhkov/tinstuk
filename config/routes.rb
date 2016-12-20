Rails.application.routes.draw do
  get 'home/index'

  get 'users/index'

  get 'users/edit'

  get 'users/profile'

  get 'users/matches'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
