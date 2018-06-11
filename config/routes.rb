Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :products
  resources :warehouses do
    member do
      post 'activity'
      post 'adjustments'
      get 'reports'
    end
  end
end
