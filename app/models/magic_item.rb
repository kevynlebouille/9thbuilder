class MagicItem < ActiveRecord::Base
  belongs_to :army
  belongs_to :magic_item_category
  has_many :army_list_unit_magic_items, dependent: :destroy
  has_many :army_list_units, through: :army_list_unit_magic_items
  has_one :override, class_name: 'MagicItem', foreign_key: 'override_id'

  active_admin_translates :name do
    validates :name, presence: true
  end

  validates :magic_item_category_id, :value_points, presence: true
  validates :value_points, numericality: { greater_than_or_equal_to: 0 }

  scope :available_for, lambda { |army, value_points_limit|
    if army.id == 3 || army.id == 5
      if value_points_limit.nil?
        includes(:translations).where('army_id = :army_id', army_id: army).order('value_points DESC', 'magic_items.name')
      else
        includes(:translations).where('army_id = :army_id', army_id: army).where('value_points <= ?', value_points_limit).order('value_points DESC', 'magic_items.name')
      end
    else
      if value_points_limit.nil?
        includes(:translations).where('army_id = :army_id OR (army_id IS NULL AND id NOT IN (SELECT override_id FROM magic_items WHERE army_id = :army_id AND override_id IS NOT NULL))', army_id: army).order('value_points DESC', 'magic_items.name')
      else
       includes(:translations). where('army_id = :army_id OR (army_id IS NULL AND id NOT IN (SELECT override_id FROM magic_items WHERE army_id = :army_id AND override_id IS NOT NULL))', army_id: army).where('value_points <= ?', value_points_limit).order('value_points DESC', 'magic_items.name')
      end
    end
  }
end
