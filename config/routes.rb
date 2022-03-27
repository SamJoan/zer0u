Rails.application.routes.draw do
  devise_for :users
  root "documents#index"

  resources :documents
end
