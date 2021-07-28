Rails.application.routes.draw do

  devise_for :customers, controllers: {
    sessions: 'public/customers/sessions',
    registrations: 'public/customers/registrations'
  }

  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions',
    registrations: 'admin/admins/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :admin do
    resources :items
    resources :orders
    resources :orders_items
    resources :genres
    
  end
end
