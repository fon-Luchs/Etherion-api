Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:create, :destroy, :update, :show] do

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
