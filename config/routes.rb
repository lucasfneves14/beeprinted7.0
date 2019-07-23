Rails.application.routes.draw do
  class SubdomainConstraint
	  def self.matches?(request)
	    request.subdomain.present? && request.subdomain == 'modeling'
	  end
	end
  get 'campanha',to: 'home#campanha', as: :campanha

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

  constraints SubdomainConstraint do
    get 'jobmodels/create'
    get 'jobmodels/destroy'


    get '/profile', to: 'hives_profiles#show', as: :hives_profile
    get '/profile/edit', to: 'hives_profiles#edit', as: :edit_hives_profile
    patch '/profile', to: 'hives_profiles#update', as: :update_hives_profile
    devise_for :modelers, path: 'modelers', controllers:{sessions:"modelers/sessions", confirmations: "modelers/confirmations", 
      passwords: "modelers/passwords", registrations: "modelers/registrations", unlocks: "modelers/unlocks"}
    resources :jobs
    post 'jobs/:id/aceitar', to:'jobs#aceitar', as: :aceitar_job
    get 'jobs/:id/enviar', to:'jobs#enviar', as: :enviar_job
    post '/jobmodels', to:'jobmodels#create', as: :jobmodels
    delete 'jobmodel/:id', to: 'jobmodels#destroy', as: :jobmodel
    patch 'jobs/:id/associar', to:'jobs#associar', as: :associar_job

  end


end
