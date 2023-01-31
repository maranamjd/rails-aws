require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  authenticate :user do
    mount Sidekiq::Web => "/sidekiq"
  end

  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
