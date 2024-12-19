Rails.application.routes.draw do
  devise_for :users


  resources :coupons, controller: 'coupon', only: [:index, :create, :destroy] do
    collection do
      post 'issue', to: 'coupon#issue'
      get 'wallet', to: 'coupon#wallet'     
      get 'new', to: 'coupon#new'   
    end
  end

  # Health check
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Root path
end
