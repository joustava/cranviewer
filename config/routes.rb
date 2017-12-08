# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root :to => 'packages#index'
  get '/', to: 'packages#index'
  get '/:id', to: 'packages#show', as: :package
  get '/:id/description', to: 'packages#description', as: :description
end
