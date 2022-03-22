Rails.application.routes.draw do
  get "/documents", to: "documents#index"

  root "documents#index"
end
