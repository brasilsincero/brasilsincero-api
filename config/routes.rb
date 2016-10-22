Rails.application.routes.draw do
  namespace :v1 do
    namespace :bolsa_familia do
      resources :payments_people, only: [:index]
      resources :payments_states, only: [:index]
    end
  end
end
