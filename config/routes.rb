Rails.application.routes.draw do
  resources :blogs
  resources :users, only: [:new, :create, :show] do
    member do
      get :favorites
    end
  end
end
