Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }


  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    # adminログイン後遷移ページ
    root :to => "orders#index"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :orders_items, only: [:update]
    end
    # get "search" => "searches#search"
  end

  scope module: :public do
    root "items#top"
    get "/about" => "items#about"
    get "customers/my_page" => "customers#show", as: "mypage"
    get "customers/unsubscribe" => "customers#unsubscribe"
    get "orders/thanks" => "orders#thanks", as: "thanks"
    post "orders/confirm" => "orders#confirm"
    patch "customers/withdraw" => "customers#withdraw"
    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    resource :customers, only: [ :edit, :update]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
    # get "search" => "searches#search"
  end

end
