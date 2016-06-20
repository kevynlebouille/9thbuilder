class ScaleUpValuePoints < ActiveRecord::Migration
  def up
    change_column :army_lists, :value_points, :decimal, :precision => 8, :scale => 2
    change_column :army_list_units, :value_points, :decimal, :precision => 8, :scale => 2
    change_column :extra_items, :value_points, :decimal, :precision => 8, :scale => 2
    change_column :magic_items, :value_points, :decimal, :precision => 8, :scale => 2
    change_column :troops, :value_points, :decimal, :precision => 8, :scale => 2
    change_column :units, :value_points, :decimal, :precision => 8, :scale => 2
    change_column :unit_options, :value_points, :decimal, :precision => 8, :scale => 2
  end

  def down
    change_column :army_lists, :value_points, :decimal, :precision => 7, :scale => 1
    change_column :army_list_units, :value_points, :decimal, :precision => 7, :scale => 1
    change_column :extra_items, :value_points, :decimal, :precision => 7, :scale => 1
    change_column :magic_items, :value_points, :decimal, :precision => 7, :scale => 1
    change_column :troops, :value_points, :decimal, :precision => 7, :scale => 1
    change_column :units, :value_points, :decimal, :precision => 7, :scale => 1
    change_column :unit_options, :value_points, :decimal, :precision => 7, :scale => 1
  end
end
