Rails.application.routes.draw do
  namespace :v1 do
    namespace :bolsa_familia do
      resources :people, only: [] do
        get :ranking, action: :index, on: :collection
      end

      resources :states, only: [] do
        get :ranking, action: :index, on: :collection
      end

      resources :yearly_costs, only: [:index]
    end
  end
end
