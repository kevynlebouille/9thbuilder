class ExtraItem < ActiveRecord::Base
  belongs_to :extra_item_category
  has_many :army_list_unit_extra_items, dependent: :destroy
  has_many :army_list_units, through: :army_list_unit_extra_items

  active_admin_translates :name do
    validates :name, presence: true
  end

  validates :extra_item_category_id, :value_points, presence: true
  validates :value_points, numericality: { greater_than_or_equal_to: 0 }

  scope :available_for, lambda { |extra_item_category, value_points_limit|
    if value_points_limit.nil?
      includes(:translations).where(extra_item_category_id: extra_item_category).order('value_points DESC', 'extra_item_translations.name')
    else
      includes(:translations).where(extra_item_category_id: extra_item_category).where('value_points <= ?', value_points_limit).order('value_points DESC', 'extra_item_translations.name')
    end
  }
end
