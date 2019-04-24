Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:create, :destroy, :update, :show] do

      resources :headings, only: [:create, :destroy, :update, :show] do

        resources :ads, except: :index

      end

    end

    resources :users, only: [:show, :index] do

      resources :headings, only: :show do

        resources :ads, only: :show

      end

    end

  end

end
