class TranslateEquipments < ActiveRecord::Migration
  def up
    Equipment.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :equipment_translations, :created_at
    remove_column :equipment_translations, :updated_at
    remove_column :equipments, :name
  end

  def down
    add_column :equipments, :name, :string, null: false

    Equipment.drop_translation_table! migrate_data: true
  end
end
