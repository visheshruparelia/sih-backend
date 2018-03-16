Rails.application.routes.draw do
  namespace :api do
    resources :allfiles, path: :file
    resources :groups
    get 'user/member', to: 'user#members_only'

  end
  mount_devise_token_auth_for 'User', at: 'api/auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
