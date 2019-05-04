Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:create, :destroy, :update, :show] do

      resources :communes, only: [:create, :destroy, :update, :show]

      resources :subscribers, only: :index

      resources :subscribings, only: :index

      resources :headings, only: [:create, :destroy, :update, :show] do

        resources :ads, except: :index do

          resources :comments, only: [:show, :create] do

            resource :like, only: :create

            resources :answers, only: :create

          end

        end

      end

    end

    resources :users, only: [:show, :index] do

      resources :communes, only: :show do
        post 'join', to: 'commune_users#create'

        delete 'leave', to: 'commune_users#destroy'
      end

      resources :subscribings, only: :create

      resources :subscribers, only: :index

      resources :headings, only: :show do

        resources :ads, only: :show do

          resource :like, only: :create

          resources :comments, only: [:show, :create] do

            resource :like, only: :create

            resources :answers, only: :create

          end

        end

      end

    end

  end

end
