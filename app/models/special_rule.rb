class SpecialRule < ActiveRecord::Base
  belongs_to :unit
  belongs_to :troop

  active_admin_translates :name, :magic, :notes do
    validates :name, presence: true
  end

  validates :unit_id, presence: true
  validates :position, numericality: { greater_than_or_equal_to: 1, only_integer: true, allow_nil: true }

  acts_as_list scope: :unit

  attr_accessor :army_filter

  def army_filter
    @army_filter ||= unit.try(:army).try(:id)
  end
end
