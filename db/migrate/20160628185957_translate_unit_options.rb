class TranslateUnitOptions < ActiveRecord::Migration
  def up
    UnitOption.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :unit_option_translations, :created_at
    remove_column :unit_option_translations, :updated_at
    remove_column :unit_options, :name
  end

  def down
    add_column :units, :name, :string, null: false

    UnitOption.drop_translation_table! migrate_data: true
  end
end
