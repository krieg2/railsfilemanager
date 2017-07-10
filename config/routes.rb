Rails.application.routes.draw do

  root 'sessions#new'

  get 'sessions/new'
  get 'sessions/destroy'
  post 'sessions/create'

  get 'download(/:user_account_id/:id)' => 'uploaded_files#download', as: 'download'

  get 'search(/:user_account_id/:term)' => 'uploaded_files#search', as: 'search_user_account_uploaded_files'

  resources :user_accounts do
    resources :uploaded_files
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
