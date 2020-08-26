Rails.application.routes.draw do
  root to: 'articles#index'
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  resources :articles do
    resources :comments
  end


end
