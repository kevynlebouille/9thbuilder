class TranslateUnits < ActiveRecord::Migration
  def up
    Unit.create_translation_table!({
      name: { type: :string, null: false },
      magic: { type: :string },
      notes: { type: :text }
    }, {
      migrate_data: true
    })

    remove_column :unit_translations, :created_at
    remove_column :unit_translations, :updated_at
    remove_column :units, :name
    remove_column :units, :magic
    remove_column :units, :notes
  end

  def down
    add_column :units, :name, :string, null: false
    add_column :units, :magic, :string
    add_column :units, :notes, :text

    Unit.drop_translation_table! migrate_data: true
  end
end
