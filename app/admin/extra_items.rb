ActiveAdmin.register ExtraItem do
  menu priority: 7

  permit_params :extra_item_category_id, :name, :value_points, translations_attributes: [:id, :locale, :name, :_destroy]

  config.sort_order = 'extra_item_translations.name_asc'

  controller do
    def scoped_collection
      super.includes(:translations, extra_item_category: [:translations])
    end

    def create
      create! { new_admin_extra_item_url }
    end
  end

  action_item :new, only: :show do
    link_to 'New Extra Item', new_admin_extra_item_path
  end

  filter :extra_item_category, collection: proc { ExtraItemCategory.includes(:translations) }
  filter :translations_name, as: :string, label: 'Name'
  filter :value_points

  index do
    selectable_column
    id_column
    column :extra_item_category, sortable: :extra_item_category_id
    column :name, sortable: 'extra_item_translations.name'
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
      f.input :extra_item_category, collection: ExtraItemCategory.includes(:translations, army: [:translations]).order(:name).collect { |ei| [ei.army.name.to_s + ' - ' + ei.name.to_s, ei.id] }
      f.input :value_points
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :extra_item_category
      translated_row :name
      row :value_points
    end
  end
end
