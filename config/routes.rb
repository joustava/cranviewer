# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get '/packages', to: 'packages#index'
  get '/packages/:id', to: 'packages#show', as: :package
  get '/packages/:id/description', to: 'packages#description', as: :description
end
