Rails.application.routes.draw do
  namespace :api do
    resources :allfiles, path: :file
    resources :groups
    post 'groups/addusers', to: 'groups#addUsers'
    post 'file/setpermissions', to: 'allfiles#setPermissionsForUsers'
    post 'file/setgroups', to: 'allfiles#setPermissionsForUsers'
    post 'groups/setauthority', to: 'groupgroup#defineAuthority'
    post 'groups/search', to: 'groups#search'
    get 'user/', to: 'user#index'
    get 'file/:id/history', to: 'history#show'

  end
  mount_devise_token_auth_for 'User', at: 'api/auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
