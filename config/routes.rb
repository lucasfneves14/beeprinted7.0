Rails.application.routes.draw do
  get 'modelings/create'
  get 'references/create'
  get 'references/destroy'
  get 'orcamentos/sucesso', to: 'orcamentos#sucesso', as: :orcamento_sucesso
  get 'modelagem/sucesso', to: 'modelings#sucesso', as: :modeling_sucesso
  get 'contato/sucesso', to: 'contatos#sucesso', as: :contato_sucesso
  resources :orcamentos
  resources :modelings
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => "callbacks" }, path_names:{ sign_in: 'login', sign_out: 'logout', sign_up:'signup'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :blogs,:path => "blog"
  resources :newsletters
  resources :profiles
  resources :posts,:path => "projeto", :controller=>"posts"
  post 'images', to: 'images#create', as: :images
  post 'arquivos', to: 'arquivos#create', as: :arquivos
  post 'references', to: 'references#create', as: :references
  post 'contatos', to: 'contatos#create', as: :contatos
  delete 'image/:id', to: 'images#destroy', as: :image
  delete 'arquivo/:id', to: 'arquivos#destroy', as: :arquivo
  delete 'reference/:id', to: 'references#destroy', as: :reference
  get "test_exception_notifier" => "application#test_exception_notifier"
  get 'politica-de-privacidade', to: 'politicas#privacidade', as: :politica_privacidade
  get 'politica-de-envio-trocas-e-devolucoes', to: 'politicas#devolucao', as: :politica_devolucao


  match "/404", :to => "not_found#not_found", :via => :all
  match "/500", :to => "not_found#internal_server_error", :via => :all
end
