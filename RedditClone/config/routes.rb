Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users
  resources :subs do 
    resources :posts, only: [:new, :create]
  end

  resources :posts, only: [ :edit, :show, :destroy, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
