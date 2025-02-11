Rails.application.routes.draw do
  root "books#index"
  resources :books, only: [:index, :show] do
    post 'borrow', on: :member
    post 'return', on: :member
  end
  resource :user, only: [:show]
  devise_for :users
end
