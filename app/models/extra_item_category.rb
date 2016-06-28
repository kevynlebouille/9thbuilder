class ExtraItemCategory < ActiveRecord::Base
  belongs_to :army
  has_many :extra_items, dependent: :destroy

  active_admin_translates :name do
    validates :name, presence: true
  end

  validates :army_id, presence: true
end
