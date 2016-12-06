Rails.application.routes.draw do
  resources :diaries, only: [:index]
  get '/search' => 'diaries#search_items'
  root to: 'diaries#index'
  get '*path' => redirect('/')
end
