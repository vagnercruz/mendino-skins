class CreateSkins < ActiveRecord::Migration[8.0]
  def change
    create_table :skins do |t|
      t.string :name, null: false
      t.string :weapon, null: false
      t.string :category
      t.string :wear_level
      t.decimal :float_value, precision: 18, scale: 17 # Definindo precisão e escala explicitamente
      t.integer :pattern_template
      t.string :image_url
      t.string :inspect_link
      t.decimal :price, precision: 10, scale: 2
      t.boolean :for_sale, default: false, null: false # Default para false
      t.references :user, null: false, foreign_key: true # Garante que a skin pertença a um usuário

      t.timestamps
    end

    add_index :skins, :weapon
    add_index :skins, :category
    add_index :skins, :wear_level
    add_index :skins, :for_sale
    add_index :skins, :price
  end
end
