class Order < ActiveRecord::Base
  belongs_to :setor
  belongs_to :user

  validates :setor_id, :periodo, presence: true

end
