Rails.application.routes.draw do
  root 'blogs#index'

  resources :blogs do
    collection do
      post :confirm
    end
  end

  resources :users, only: [:index, :new, :create, :show, :edit, :update] do
    member do
      get :favorites
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :favorites, only: [:create, :destroy]

  resources :relationships, only: [:create, :destroy]

  resources :conversations do
    resources :messages
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
