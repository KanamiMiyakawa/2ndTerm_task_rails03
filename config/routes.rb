Rails.application.routes.draw do

  resources :blogs do
    collection do
      post :confirm
    end
  end

  resources :users, only: [:new, :create, :show, :edit, :update] do
    member do
      get :favorites
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :favorites, only: [:create, :destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
