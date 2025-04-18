Rails.application.config.middleware.use OmniAuth::Builder do
  # Carrega a chave da API do arquivo .env
  provider :steam, ENV["STEAM_API_KEY"]
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
