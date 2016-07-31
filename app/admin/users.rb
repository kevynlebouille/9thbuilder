ActiveAdmin.register User do
  menu priority: 9, url: -> { admin_users_path }

  filter :email
  filter :name

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :favorite_army, sortable: :favorite_army_id
    column :created_at
    column :updated_at
    actions
  end
end
