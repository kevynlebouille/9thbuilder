ActiveAdmin.register UnitOption do
  menu parent: 'Units', url: -> { admin_unit_options_path }

  permit_params :unit_id, :parent_id, :mount_id, :name, :value_points, :position, :is_per_model, :is_multiple, :is_magic_items, :is_magic_standards, :is_extra_items, :is_unique_choice, translations_attributes: [:id, :locale, :name, :_destroy]

  controller do
    def scoped_collection
      super.includes(:translations, unit: [:translations], parent: [:translations], mount: [:translations])
    end

    def create
      create! { new_admin_unit_option_url }
    end
  end

  member_action :move_higher, method: :post do
    resource.move_higher
    resource.save

    redirect_to admin_unit_url(resource.unit)
  end

  member_action :move_lower, method: :post do
    resource.move_lower
    resource.save

    redirect_to admin_unit_url(resource.unit)
  end

  action_item :new, only: :show do
    link_to 'New Unit Option', new_admin_unit_option_path('unit_option[unit_id]' => unit_option.unit)
  end

  filter :unit, collection: proc { Unit.includes(:translations, army: [:translations]).order('army_translations.name', 'unit_translations.name').collect { |r| [r.army.name.to_s + ' - ' + r.name.to_s, r.id] } }
  filter :translations_name, as: :string, label: 'Name'
  filter :value_points

  index do
    selectable_column
    id_column
    column :unit, sortable: 'unit_translations.name'
    column :mount, sortable: :mount_id
    column :name, sortable: 'unit_option_translations.name'
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
      f.input :army_filter, as: :select, collection: Army.includes(:translations).order(:name), disabled: Army.disabled.pluck(:id), label: 'Army FILTER'
      f.input :unit, collection: Unit.includes(:translations, { army: [:translations] }).order('army_translations.name', 'unit_translations.name').collect { |u| [u.army.name.to_s + ' - ' + u.name.to_s, u.id] }
      f.input :parent, collection: UnitOption.includes(unit: [:translations, { army: [:translations] }]).order('army_translations.name', 'unit_translations.name', 'unit_options.position').collect { |uo| [uo.unit.army.name.to_s + ' - ' + uo.unit.name.to_s + ' - ' + uo.name.to_s, uo.id] }
      f.input :mount, collection: Unit.includes(:translations, { army: [:translations] }).mount_category.order('army_translations.name', 'unit_translations.name').collect { |u| [u.army.name.to_s + ' - ' + u.name.to_s, u.id] }
      f.input :value_points
      f.input :position
      f.input :is_per_model
      f.input :is_multiple
      f.input :is_magic_items
      f.input :is_magic_standards
      f.input :is_extra_items
      f.input :is_unique_choice
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :unit
      row :parent
      row :mount
      translated_row :name
      row :value_points
      row :position
      row :is_per_model
      row :is_multiple
      row :is_magic_items
      row :is_magic_standards
      row :is_extra_items
      row :is_unique_choice
    end
  end
end
