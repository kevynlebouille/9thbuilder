class TranslateUnitCategories < ActiveRecord::Migration
  def up
    UnitCategory.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :unit_category_translations, :created_at
    remove_column :unit_category_translations, :updated_at
    remove_column :unit_categories, :name
  end

  def down
    add_column :unit_categories, :name, :string, null: false

    UnitCategory.drop_translation_table! migrate_data: true
  end
end
