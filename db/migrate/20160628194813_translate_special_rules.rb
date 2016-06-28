class TranslateSpecialRules < ActiveRecord::Migration
  def up
    SpecialRule.create_translation_table!({
      name: { type: :string, null: false }
    }, {
      migrate_data: true
    })

    remove_column :special_rule_translations, :created_at
    remove_column :special_rule_translations, :updated_at
    remove_column :special_rules, :name
  end

  def down
    add_column :special_rules, :name, :string, null: false

    SpecialRule.drop_translation_table! migrate_data: true
  end
end
