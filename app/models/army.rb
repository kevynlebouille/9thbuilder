class Army < ActiveRecord::Base
  has_many :magic_items, :dependent => :destroy
  has_many :units, :dependent => :destroy

  validates_presence_of :name
end
