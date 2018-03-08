Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :systems do
    resource :appliances
  end

  get 'appliances/detailslByName', to: 'appliances#details_by_name'
  get 'appliances/poolConfig', to: 'pool_configurations#get_pool_config'
  resources :appliances do
  	resources :pool_configurations
  	get :details, on: :member
  end

  

end
