class MagicItemCategory < ActiveRecord::Base
  has_many :magic_items, dependent: :destroy

  active_admin_translates :name do
    validates :name, presence: true
  end
end
