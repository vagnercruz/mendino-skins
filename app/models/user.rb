class User < ApplicationRecord
  has_many :skins, dependent: :destroy

  # Adicionar o método de autenticação mais tarde
end
