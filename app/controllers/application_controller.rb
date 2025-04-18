# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Disponibiliza os métodos para as views também
  helper_method :current_user, :logged_in?

  private

  def current_user
    # Encontra o usuário pelo ID armazenado na sessão, usando memoization (@current_user ||=)
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # Verifica se current_user não é nulo
    !!current_user
  end

  def require_user
    # Redireciona para a página inicial se o usuário não estiver logado
    unless logged_in?
      redirect_to root_path, alert: "Você precisa estar logado para acessar esta página."
    end
  end
end
