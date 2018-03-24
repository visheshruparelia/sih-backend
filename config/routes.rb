Rails.application.routes.draw do
  namespace :api do
    resources :allfiles, path: :file
    resources :groups
    post 'fileuser/', to: 'fileusers#create'
    post 'groupgroup/', to: 'groupgroup#create'
    get 'user/', to: 'user#index'
    post 'groupuser/', to:'groupusers#create'
    get 'file/:id/history', to: 'history#show'
    get 'groups/:id/users', to: 'groupusers#show'

  end
  mount_devise_token_auth_for 'User', at: 'api/auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
