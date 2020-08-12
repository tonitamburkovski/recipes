class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.float :qty
      t.string :unit
      t.string :ingredient
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
