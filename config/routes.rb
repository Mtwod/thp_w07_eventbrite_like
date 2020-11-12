Rails.application.routes.draw do
  # to redirect user after sign in to a specific method
  devise_for :users
  root 'events#index'
  resources :users
  resources :events do
    resources :attendances
  end

  namespace :admin do
    root 'base#index'
    resources :users
    resources :events
    resources :event_submissions, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
