Rails.application.routes.draw do
  get 'images/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :posts,:path => "projeto", :controller=>"posts"
  post 'images', to: 'images#create', as: :images
  delete 'image/:id', to: 'images#destroy', as: :image
end
