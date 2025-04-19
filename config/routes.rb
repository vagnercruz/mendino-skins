# config/routes.rb
Rails.application.routes.draw do
  devise_for :admins
  # Rota que o usuário clica para iniciar o login com Steam
  get "/auth/steam", as: "steam_login"

  # Rota de callback para onde a Steam redireciona após o login
  match "/auth/:provider/callback", to: "sessions#create", via: [ :get, :post ]

  # Rota para tratar falhas na autenticação
  get "/auth/failure", to: "sessions#failure"

  # Rota para logout
  delete "/logout", to: "sessions#destroy", as: "logout"

  # Define a página inicial (vamos criar um controller 'pages' para isso)
  root "pages#home"

  # Rotas para skins (vamos criar depois)
  resources :skins, only: [ :index, :show ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
