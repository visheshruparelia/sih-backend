Rails.application.routes.draw do
  resources :allfiles
  mount_devise_token_auth_for 'User', at: 'api/auth'
  get 'user/member', to: 'user#members_only'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
