Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :systems do
    resource :appliances
  end

  resources :appliances do
  	get :details, on: :member
  end

  resources :pool_configurations do
  end
end