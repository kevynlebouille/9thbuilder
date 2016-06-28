ActiveAdmin.register Equipment do
  menu priority: 5

  permit_params :unit_id, :troop_id, :name, :position, translations_attributes: [:id, :locale, :name, :_destroy]

  controller do
    def scoped_collection
      super.includes(:translations, unit: [:translations], troop: [:translations])
    end

    def create
      create! { new_admin_equipment_url }
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

  collection_action :sort, method: :post do
    params[:equipment].each_with_index do |id, index|
      Equipment.update_all({ position: index + 1 }, unit_id: params[:unit_id], id: id)
    end
    render nothing: true
  end

  action_item :new, only: :show do
    link_to 'New Equipment', new_admin_equipment_path('equipment[unit_id]' => equipment.unit)
  end

  filter :unit, collection: proc { Unit.includes(:translations, army: [:translations]).order('army_translations.name', 'unit_translations.name').collect { |r| [r.army.name.to_s + ' - ' + r.name.to_s, r.id] } }
  filter :translations_name, as: :string, label: 'Name'

  index do
    selectable_column
    id_column
    column :unit, sortable: :unit_id
    column :name, sortable: 'equipment_translations.name'
    column :troop, sortable: :troop_id
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
      f.input :unit, collection: Unit.includes(:translations, army: [:translations]).order('army_translations.name', 'unit_translations.name').collect { |u| [u.army.name.to_s + ' - ' + u.name.to_s, u.id] }
      f.input :troop, collection: Troop.includes(:translations, unit: [:translations, army: [:translations]]).order('army_translations.name', 'unit_translations.name', 'troops.position').collect { |t| [t.unit.army.name.to_s + ' - ' + t.unit.name.to_s + ' - ' + t.name.to_s, t.id] }
      f.input :position
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :unit
      row :troop
      translated_row :name
      row :position
    end
  end
end
