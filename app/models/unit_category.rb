class UnitCategory < ActiveRecord::Base
  has_many :units, dependent: :destroy

  active_admin_translates :name do
    validates :name, presence: true
  end
end
