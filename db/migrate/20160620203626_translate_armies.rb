class TranslateArmies < ActiveRecord::Migration
  def up
    Army.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :army_translations, :created_at
    remove_column :army_translations, :updated_at
    remove_column :armies, :name
  end

  def down
    add_column :armies, :name, :string, null: false

    Army.drop_translation_table! migrate_data: true
  end
end
