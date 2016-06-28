class TranslateExtraItemCategories < ActiveRecord::Migration
  def up
    ExtraItemCategory.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :extra_item_category_translations, :created_at
    remove_column :extra_item_category_translations, :updated_at
    remove_column :extra_item_categories, :name
  end

  def down
    add_column :extra_item_categories, :name, :string, null: false

    ExtraItemCategory.drop_translation_table! migrate_data: true
  end
end
