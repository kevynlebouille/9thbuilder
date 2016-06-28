ActiveAdmin.register ExtraItemCategory do
  menu parent: 'Extra Items'

  permit_params :army_id, :name, translations_attributes: [:id, :locale, :name, :_destroy]

  config.sort_order = 'extra_item_category_translations.name_asc'

  controller do
    def scoped_collection
      super.includes(:translations, army: [:translations])
    end
  end

  filter :army, collection: proc { Army.includes(:translations) }
  filter :translations_name, as: :string, label: 'Name'

  index do
    selectable_column
    id_column
    column :army, sortable: :army_id
    column :name, sortable: 'extra_item_category_translations.name'
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
      f.input :army, collection: Army.includes(:translations)
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :army
      translated_row :name
    end
  end
end
