# config/routes.rb
Rails.application.routes.draw do
  # --- Autenticação ---

  # Rotas do Devise para Administradores (ex: /admins/sign_in, /admins/sign_out)
  devise_for :admins

  # Rotas do OmniAuth (Steam) para Usuários comuns
  get "/auth/steam", as: "steam_login"                        # Usuário clica aqui para logar com Steam
  match "/auth/:provider/callback", to: "sessions#create", via: [ :get, :post ] # Steam redireciona para cá
  get "/auth/failure", to: "sessions#failure"                # Rota para falha na autenticação Steam
  delete "/logout", to: "sessions#destroy", as: "logout"      # Rota para logout do Usuário comum (Steam)

  # --- Área Administrativa ---
  namespace :admin do
    # Rota raiz da área admin, aponta para a listagem de skins do admin
    # Acessível em /admin
    root to: "skins#index"

    # Rotas para gerenciar Skins (CRUD) dentro da área /admin
    # Gera rotas como /admin/skins, /admin/skins/new, /admin/skins/:id/edit etc.
    resources :skins # Linha corrigida (era :ski)
  end

  # --- Área Pública ---

  # Rotas públicas para visualização das Skins do portfólio
  # only: [:index, :show] -> Apenas listar todas e ver detalhes de uma
  # path: 'portfolio' -> Acessível via /portfolio e /portfolio/:id
  resources :skins, only: [ :index, :show ], path: "portfolio"

  # Rota raiz da aplicação (página inicial)
  # Acessível em /
  root "pages#home"
end
