ActiveAdmin.register Army do
  menu priority: 2

  permit_params :name, translations_attributes: [:id, :locale, :name, :_destroy]

  config.sort_order = 'army_translations.name_asc'

  controller do
    def scoped_collection
      super.includes(:translations)
    end
  end

  filter :translations_name, as: :string, label: 'Name'

  index do
    selectable_column
    id_column
    column :name, sortable: 'army_translations.name'
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

  member_action :duplicate, method: :post do
    new_army = resource.duplicate
    new_army.save

    redirect_to edit_admin_army_url(new_army)
  end

  action_item :duplicate, only: :show do
    link_to 'Duplicate Army', duplicate_admin_army_path(army), method: :post
  end
end
