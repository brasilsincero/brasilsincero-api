Rails.application.routes.draw do
  namespace :v1 do
    namespace :bolsa_familia do
      resources :payments_ranking, only: [:index]
    end
  end
end
