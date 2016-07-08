Rails.application.routes.draw do

  #session page
  resources :comments, only: [:new, :create, :index]
  match '/auth/:provider/callback', to: 'sessions#create', via: 'get'
    get '/auth/failure', to: 'sessions#auth_fail'
    get '/sign_out', to: 'sessions#destroy', as: :sign_out

  #root to: 'comments#new'
  root to: 'listings#index'
  #listings
  resources :listings
  resources :orders
  resources :listings do
    resources :orders
    resources :listreviews
  end
  get 'listingreview' => "listingreview#new"

  get 'seller' => "listings#seller"
  get 'sales' => "orders#sales"
  get 'purchases' => "orders#purchases"

  #mentorings
  resources :meetings
  resources :mentorings do
    resources :meetings, only: [:new, :create]
  end
  get 'seller' => "mentorings#seller"
  get 'sales' => "meetings#sales"
  get 'purchases' => "meetings#purchases"


  #zoom.us
  get 'new_link', to: 'zoom#generate_new'
  resources :zoom
  #Users (devise)
  devise_for :users,
    :controllers => { registrations: 'registrations',
                      omniauth_callbacks:  'omniauth_callbacks'} #<-- that thing is for STRIPE!
  #STRIPE
  resources :charges
  #MAILBOXER
  resources :conversations, only: [:index, :show, :destroy] do
      member do
        post :reply
        post :restore
        post :mark_as_read
      end
      collection do
        delete :empty_trash
      end
  end
  resources :messages, only: [:new, :create]

  #user reviews and videos
  get "/panda/authorize_upload", :to => "panda#authorize_upload"
  get "/panda/authorize_upload_postprocess", :to => "panda#authorize_upload_postprocess"
  get "/new", :to => "videos#new"
  get "/advanced", :to => "videos#advanced"
  get "/videos/postprocess", :to => "videos#postprocess"
  resources :videos
  resources :users do
    resources :reviews
    resources :videos
  end

  #categories associatoin
  resources :categories, except: [:destroy]

  get 'profile', to: 'users#show'

  # Jonathan added: list categoris association
    resources :listing_categories, except: [:destroy]

end
