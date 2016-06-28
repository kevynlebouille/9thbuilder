class TranslateExtraItems < ActiveRecord::Migration
  def up
    ExtraItem.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :extra_item_translations, :created_at
    remove_column :extra_item_translations, :updated_at
    remove_column :extra_items, :name
  end

  def down
    add_column :extra_items, :name, :string, null: false

    ExtraItem.drop_translation_table! migrate_data: true
  end
end
