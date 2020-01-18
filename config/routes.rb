Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :artists do
        resources :records
      end
      resources :companies
      resources :company_reviews
      resources :records
    end
  end

  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy
end

