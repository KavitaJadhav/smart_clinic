Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :doctors, only: [] do
        member do
          get :working_days
        end
      end
      post "authentication/login", to: "authentication#login"
    end
  end
end
