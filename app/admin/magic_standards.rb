ActiveAdmin.register MagicStandard do
  menu parent: 'Magic Items', priority: 1

  permit_params :army_id, :override_id, :name, :value_points, translations_attributes: [:id, :locale, :name, :_destroy]

  config.sort_order = 'magic_standard_translations.name_asc'

  controller do
    def scoped_collection
      super.includes(:translations, army: [:translations], override: [:translations])
    end

    def create
      create! { new_admin_magic_standard_url }
    end
  end

  action_item :new, only: :show do
    link_to 'New Magic Standard', new_admin_magic_standard_url
  end

  filter :army, collection: proc { Army.includes(:translations) }
  filter :translations_name, as: :string, label: 'Name'
  filter :value_points

  index do
    selectable_column
    id_column
    column :army, sortable: :army_id
    column :name, sortable: 'magic_standard_translations.name'
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
      f.input :override, collection: MagicStandard.includes(:translations).where(army_id: nil).order(:name)
      f.input :value_points
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :army
      row :override
      translated_row :name
      row :value_points
    end
  end
end
