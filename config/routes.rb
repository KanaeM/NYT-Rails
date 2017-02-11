Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'news#index'

  resources :news

  # get 'news/:id'
  # get 'news/new'
  # get 'news/search'
  # get 'news/saved'
end
