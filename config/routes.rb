Rails.application.routes.draw do

    root to: 'customers/homes#top'
    devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
    devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  
  namespace :admin do
         root to: 'homes#top'
         resources :genres, only: [:edit, :update, :create, :index, :destroy]
         resources :users, only: [:edit, :update, :show]
         get '/users' => 'users#index'
  end
  
  root to: 'homes#top'
  scope module: :customers do
    resources :users, only: [:edit, :update, :show] do
      member do
        get :likes
      end
    end
    get '/posts/new' => 'posts#new'
    get '/posts' => 'posts#index'
    get 'search' => 'posts#search'
    resources :posts, only: [:edit, :destroy, :create, :show] do
      resources :comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
  end
  root to: 'customers/homes#top'
  
end
