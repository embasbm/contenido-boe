Rails.application.routes.draw do
  resources :diaries, only: [:index]
  root to: 'diaries#index'
  get '*path' => redirect('/')
end
