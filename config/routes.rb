Rails.application.routes.draw do
  root 'static_pages#home'
  
  mount ActionCable.server, at: '/cable'

  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/chat', to: 'chat#room'
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
