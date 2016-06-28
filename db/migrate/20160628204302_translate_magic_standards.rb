class TranslateMagicStandards < ActiveRecord::Migration
  def up
    MagicStandard.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :magic_standard_translations, :created_at
    remove_column :magic_standard_translations, :updated_at
    remove_column :magic_standards, :name
  end

  def down
    add_column :magic_standards, :name, :string, null: false

    MagicStandard.drop_translation_table! migrate_data: true
  end
end
