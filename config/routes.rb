Rails.application.routes.draw do
  namespace :api do
    resources :allfiles, path: :file
    resources :groups
    post 'fileuser/', to: 'fileusers#create'
    post 'groupgroup/', to: 'groupgroup#create'
    get 'users/', to: 'user#index'
    post 'groupuser/', to:'groupusers#create'
    get 'file/:id/history', to: 'history#show'
    get 'groups/:id/users', to: 'groupusers#show'
    get 'users/:id/files', to: 'fileusers#show'
    get 'users/:id/groups', to: 'groupusers#showgroups'
    post 'users/create', to: 'user#make'
    get 'users/:id', to: 'user#show'
    get 'users/:id/report', to: 'report#create'
    get 'users/:id/authorityover', to: 'groupgroup#authorityover'
    get 'file/lastuser/:id', to: 'history#lastuser'
  end
  mount_devise_token_auth_for 'User', at: 'api/auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
