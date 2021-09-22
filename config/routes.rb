Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }


  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    # adminログイン後遷移ページ
    root :to => "orders#index"
    get "/search" => "orders#search"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_items, only: [:update]
    end
  end

  scope module: :public do
    root "items#top"
    get "/about" => "items#about"
    get "customers/my_page" => "customers#show", as: "mypage"
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    put 'customers/information' => 'customers#update'
    get "customers/unsubscribe" => "customers#unsubscribe"
    get "orders/thanks" => "orders#thanks", as: "thanks"
    post "orders/confirm" => "orders#confirm"
    patch "customers/withdraw" => "customers#withdraw"
    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    resources :items, only: [:index, :show] do
      resources :cart_items, only: [:create, :update, :destroy]
    end
    resources :cart_items, only: [:index]
    resources :orders, only: [:new, :create, :index, :show]
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
    # get "search" => "searches#search"
  end

end
