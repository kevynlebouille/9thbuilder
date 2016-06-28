ActiveAdmin.register MagicItemCategory do
  menu parent: 'Magic Items'

  permit_params :name, translations_attributes: [:id, :locale, :name, :_destroy]

  config.sort_order = 'magic_item_category_translations.name_asc'

  controller do
    def scoped_collection
      super.includes(:translations)
    end
  end

  filter :translations_name, as: :string, label: 'Name'

  index do
    selectable_column
    id_column
    column :name, sortable: 'magic_item_category_translations.name'
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
    f.actions
  end

  show do
    attributes_table do
      row :id
      translated_row :name
    end
  end
end
