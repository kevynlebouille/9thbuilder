class TroopType < ActiveRecord::Base
  has_many :troops, dependent: :destroy

  active_admin_translates :name do
    validates :name, presence: true
  end
end
