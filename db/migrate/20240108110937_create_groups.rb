class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.binary :icon
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :entity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
