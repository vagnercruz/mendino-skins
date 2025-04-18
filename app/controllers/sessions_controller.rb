class SessionsController < ApplicationController
  def create
    auth_hash = request.env["omniauth.auth"]

    # Tenta encontrar um usuário existente ou cria um novo
    user = User.find_or_create_by(provider: auth_hash["provider"], uid: auth_hash["uid"]) do |u|
      u.nickname = auth_hash["info"]["nickname"]
      u.avatar_url = auth_hash["info"]["image"]
      u.profile_url = auth_hash["info"]["urls"]["profile"]
    end

    if user.persisted?
      # Armazena o ID do usuário na sessão para mantê-lo logado
      session[:user_id] = user.id
      redirect_to root_path, notice: "Login realizado com sucesso como #{user.nickname}!"
    else
      # Se algo deu errado ao salvar o usuário
      redirect_to root_path, alert: "Erro durante o login com Steam. #{user.errors.full_messages.join(', ')}"
    end

  rescue StandardError => e
    # Captura qualquer erro inesperado durante o processo
    Rails.logger.error("Erro na autenticação Steam: #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    redirect_to root_path, alert: "Ocorreu um erro inesperado durante o login com Steam."
  end

  def destroy
    # Remove o ID do usuário da sessão (logout)
    session[:user_id] = nil
    redirect_to root_path, notice: "Logout realizado com sucesso!"
  end

  def failure
    # Exibe uma mensagem de erro se a autenticação falhar
    redirect_to root_path, alert: "Falha na autenticação: #{params[:message]}"
  end
end
