Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end

  root 'pages#index'

  namespace :api do
    namespace :v1 do

    end
  end

end
