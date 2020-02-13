Rails.application.routes.draw do
  get 'version/create'
  get 'adicionados/create'
  get 'manual/index'
  class SubdomainConstraint
	  def self.matches?(request)
	    request.subdomain.present? && request.subdomain == 'modeling'
	  end
	end


  root 'home#index'
  get 'brindes-corporativos', to: 'home#brindes', as: :brindes
  get 'trofeus-personalizados', to: 'home#trofeus', as: :trofeus


  get '/system', to:'system#index', as: :system
  post 'system/adicionados', to: 'adicionados#create', as: :adicionados
  get 'system/orcamentos/:id', to:'system#edit', as: :system_edit
  #get 'system/modelagens/:id', to:'system#modelagem', as: :system_modelagem
  #get 'system/adicionados/:id', to:'system#adicionado', as: :system_adicionado
  patch 'system/orcamentos/:id', to: 'system#update', as: :system_update
  get 'system/localizacao', to:'system#localizacao', as: :system_localizacao
  get 'system/farol', to:'system#farol', as: :system_farol
  get 'system/usuarios', to:'system#usuarios', as: :system_usuarios
  get 'system/avaliacao', to: 'avaliacoes#show', as: :avaliacao
  patch 'system/avaliacao/:id', to: 'avaliacoes#update', as: :avaliacao_update
  patch 'system/enviar-avaliacao/:id', to: 'system#enviar_avaliacao', as: :avaliacao_enviar
  

  get 'jobs', to: 'producao#jobs', as: :producao_jobs
  post 'jobs/:id/aceitar', to: 'producao#aceitar_job', as: :producao_jobs_aceitar
  get 'producao', to: 'producao#index', as: :producao
  get 'producao/:id', to: 'producao#show', as: :producao_show


  post 'system/versao/:id', to: 'version#create', as: :system_version
  post 'system/principal/:id', to: 'version#principal', as: :system_principal




  get 'suporte/manual-para-solucao-de-erros-de-impressao-3d', to: 'manual#index', as: :manual
  get 'suporte/manual-para-solucao-de-erros-de-impressao-3d/:id', to: 'manual#show', as: :erro
  get 'suporte/manual-para-solucao-de-erros-de-impressao-3d/:id/edit', to: 'manual#edit', as: :edit_erro
  patch 'suporte/manual-para-solucao-de-erros-de-impressao-3d/:id', to: 'manual#update', as: :update_erro
  get 'suporte/erros/new', to: 'manual#new', as: :erro_new
  post 'suporte/erros', to: 'manual#create', as: :erros
  get 'campanha',to: 'home#campanha', as: :campanha

  get 'modelings/create'
  get 'references/create'
  get 'references/destroy'
  get 'orcamentos/sucesso', to: 'orcamentos#sucesso', as: :orcamento_sucesso
  get 'modelagem/sucesso', to: 'modelings#sucesso', as: :modeling_sucesso
  get 'contato/sucesso', to: 'contatos#sucesso', as: :contato_sucesso
  get 'orcamentos/tipo', to: 'orcamentos#tipo', as: :tipo_orcamento
  resources :orcamentos
  resources :modelings
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => "callbacks" }, path_names:{ sign_in: 'login', sign_out: 'logout', sign_up:'signup'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :blogs,:path => "blog"
  resources :newsletters
  resources :profiles
  resources :posts,:path => "projeto", :controller=>"posts"
  post 'images', to: 'images#create', as: :images


  post 'arquivos', to: 'arquivos#create', as: :arquivos
  post 'items', to: 'items#create', as: :items



  post 'references', to: 'references#create', as: :references
  post 'contatos', to: 'contatos#create', as: :contatos
  delete 'image/:id', to: 'images#destroy', as: :image


  delete 'arquivo/:id', to: 'arquivos#destroy', as: :arquivo
  delete 'item/:id', to: 'items#destroy', as: :item


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
    get '/pagamentos', to: 'hives_profiles#pagamentos', as: :pagamentos
    get '/instrucoes', to: 'hives_profiles#instrucoes', as: :instrucoes
    get '/ajuda', to: 'hives_profiles#ajuda', as: :ajuda
    devise_for :modelers, path: 'modelers', controllers:{sessions:"modelers/sessions", confirmations: "modelers/confirmations", 
      passwords: "modelers/passwords", registrations: "modelers/registrations", unlocks: "modelers/unlocks"}
    get 'jobs/meus-jobs', to:'jobs#meus_jobs', as: :meus_jobs
    get 'jobs/analisar', to:'jobs#analisar', as: :analisar_job
    get 'jobs/abertos', to:'jobs#abertos', as: :abertos_job
    get 'jobs/aprovados', to:'jobs#aprovados', as: :aprovados_job
    get 'jobs/reprovados', to:'jobs#reprovados', as: :reprovados_job
    resources :jobs
    post 'jobs/:id/aceitar', to:'jobs#aceitar', as: :aceitar_job
    get 'jobs/:id/enviar', to:'jobs#enviar', as: :enviar_job
    post '/jobmodels', to:'jobmodels#create', as: :jobmodels
    delete 'jobmodel/:id', to: 'jobmodels#destroy', as: :jobmodel
    patch 'jobs/:id/associar', to:'jobs#associar', as: :associar_job
    post 'jobs/:id/aprovar', to: 'jobs#aprovar', as: :aprovar_job
    get 'jobs/:id/desaprovar', to: 'jobs#desaprovar', as: :desaprovar_job
    get 'jobs/:id/avaliar', to: 'jobs#avaliar', as: :avaliar_job
    get 'jobmodels/:id', to: 'view3d#show', as: :view3d

  end


end
