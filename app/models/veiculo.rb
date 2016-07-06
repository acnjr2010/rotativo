class Veiculo < ActiveRecord::Base
  belongs_to :user

  validates :placa_veiculo, :tipo, :modelo, :cor, presence: true
  validates_uniqueness_of :placa_veiculo
  validates_format_of :placa_veiculo, with: /[A-Z]{3}-[0-9]{4}/i, create: :on
end
