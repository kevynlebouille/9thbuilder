ActiveAdmin.register MagicItem do
  menu priority: 8

  permit_params :army_id, :magic_item_category_id, :override_id, :name, :value_points, :is_multiple, translations_attributes: [:id, :locale, :name, :_destroy]

  config.sort_order = 'magic_item_translations.name_asc'

  controller do
    def scoped_collection
      super.includes(:translations, army: [:translations], magic_item_category: [:translations], override: [:translations])
    end

    def create
      create! { new_admin_magic_item_url }
    end
  end

  action_item :new, only: :show do
    link_to 'New Magic Item', new_admin_magic_item_path
  end

  filter :army, collection: proc { Army.includes(:translations) }
  filter :magic_item_category, collection: proc { MagicItemCategory.includes(:translations) }
  filter :translations_name, as: :string, label: 'Name'
  filter :value_points

  index do
    selectable_column
    id_column
    column :army, sortable: :army_id
    column :magic_item_category, sortable: :magic_item_category_id
    column :name, sortable: 'magic_item_translations.name'
    column :value_points
    translation_status_flags
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs 'Translated fields' do
      f.translated_inputs '', switch_locale: false do |t|
        t.input :name
      end
    end
    f.inputs 'Common fields' do
      f.input :army, collection: Army.includes(:translations).order(:name)
      f.input :magic_item_category, collection: MagicItemCategory.includes(:translations).order(:name)
      f.input :override, collection: MagicItem.includes(:translations).where(army_id: nil).order(:name)
      f.input :value_points
      f.input :is_multiple
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :army
      row :magic_item_category
      row :override
      translated_row :name
      row :value_points
      row :is_multiple
    end
  end
end
