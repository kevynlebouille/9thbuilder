class User < ActiveRecord::Base
  has_many :army_lists, dependent: :destroy
  has_many :armies, -> { distinct }, through: :army_lists
  belongs_to :favorite_army, class_name: 'Army'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, email_regexp: /@/

  validates :name, presence: true

  normalize_attributes :name, :locale

  def update_with_password(params = {})
    params.delete :current_password
    update_without_password params
  end
end
