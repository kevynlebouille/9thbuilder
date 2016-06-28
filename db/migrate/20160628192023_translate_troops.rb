class TranslateTroops < ActiveRecord::Migration
  def up
    Troop.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :troop_translations, :created_at
    remove_column :troop_translations, :updated_at
    remove_column :troops, :name
  end

  def down
    add_column :troops, :name, :string, null: false

    Troop.drop_translation_table! migrate_data: true
  end
end
