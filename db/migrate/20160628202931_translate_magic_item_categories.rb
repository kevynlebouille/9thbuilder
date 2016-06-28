class TranslateMagicItemCategories < ActiveRecord::Migration
  def up
    MagicItemCategory.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :magic_item_category_translations, :created_at
    remove_column :magic_item_category_translations, :updated_at
    remove_column :magic_item_categories, :name
  end

  def down
    add_column :magic_item_categories, :name, :string, null: false

    MagicItemCategory.drop_translation_table! migrate_data: true
  end
end
