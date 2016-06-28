class TranslateTroopTypes < ActiveRecord::Migration
  def up
    TroopType.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :troop_type_translations, :created_at
    remove_column :troop_type_translations, :updated_at
    remove_column :troop_types, :name
  end

  def down
    add_column :troop_types, :name, :string, null: false

    TroopType.drop_translation_table! migrate_data: true
  end
end
