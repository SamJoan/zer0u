Rails.application.routes.draw do
  devise_for :users

  root "documents#index"
  resources :documents

  get "/documents_insecure/show/:id", to: 'documents#show_insecure'
end
