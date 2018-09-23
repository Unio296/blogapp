Rails.application.routes.draw do

  root 'static_pages#home'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :articles, only: [:new, :create, :show, :destroy, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
