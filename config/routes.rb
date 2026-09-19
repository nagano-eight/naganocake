Rails.application.routes.draw do
  devise_for :customers,
             skip: [ :passwords ],
             controllers: {
               registrations: "public/registrations",
               sessions: "public/sessions"
             }

  devise_for :admins,
             path: "admin",
             skip: [ :registrations, :passwords ],
             controllers: {
               sessions: "admin/sessions"
             }

  scope module: :public do
    root to: "homes#top"
    get "about", to: "homes#about"

    resources :items, only: [ :index, :show ]

    get "customers/my_page", to: "customers#show", as: :customers_my_page
    get "customers/information/edit", to: "customers#edit", as: :edit_customers_information
    patch "customers/information", to: "customers#update", as: :customers_information
    get "customers/unsubscribe", to: "customers#unsubscribe", as: :customers_unsubscribe
    patch "customers/withdraw", to: "customers#withdraw", as: :customers_withdraw

    resources :cart_items, only: [ :index, :create, :update, :destroy ] do
      collection do
        delete :destroy_all
      end
    end

    resources :orders, only: [ :new, :create, :index, :show ] do
      collection do
        post :confirm
        get :thanks
      end
    end

    resources :addresses, only: [ :index, :edit, :create, :update, :destroy ]
  end

  namespace :admin do
    root to: "homes#top"
    resources :items, except: [ :destroy ]
    resources :genres, only: [ :index, :create, :edit, :update ]
    resources :customers, only: [ :index, :show, :edit, :update ]
    resources :orders, only: [ :show, :update ]
    resources :order_details, only: [ :update ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
