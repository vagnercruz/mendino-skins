class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :nickname
      t.string :avatar_url
      t.string :profile_url

      t.timestamps
    end
       # índice único para a combinação de provider e uid
       add_index :users, [ :provider, :uid ], unique: true
       # índice no uid para buscas rápidas
       add_index :users, :uid
  end
end
