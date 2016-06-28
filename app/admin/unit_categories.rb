ActiveAdmin.register UnitCategory do
  menu parent: 'Units'

  permit_params :name, :min_quota, :max_quota, translations_attributes: [:id, :locale, :name, :_destroy]

  config.sort_order = 'unit_category_translations.name_asc'
  config.filters = false

  controller do
    def scoped_collection
      super.includes(:translations)
    end
  end

  index do
    selectable_column
    id_column
    column :name, sortable: 'unit_category_translations.name'
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
      f.input :min_quota
      f.input :max_quota
      f.input :warband_max_duplicate
      f.input :army_max_duplicate
      f.input :grand_army_max_duplicate
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      translated_row :name
      row :min_quota
      row :max_quota
      row :warband_max_duplicate
      row :army_max_duplicate
      row :grand_army_max_duplicate
    end
  end
end
