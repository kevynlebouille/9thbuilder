class TranslateMagicItems < ActiveRecord::Migration
  def up
    MagicItem.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :magic_item_translations, :created_at
    remove_column :magic_item_translations, :updated_at
    remove_column :magic_items, :name
  end

  def down
    add_column :magic_items, :name, :string, null: false

    MagicItem.drop_translation_table! migrate_data: true
  end
end
