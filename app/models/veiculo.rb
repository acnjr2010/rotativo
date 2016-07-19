class Veiculo < ActiveRecord::Base
  before_save :veiculo_upcase

  belongs_to :user
  has_many :bilhetes
  has_many :bilhetepvs

  validates :placa_veiculo, :tipo, :modelo, :cor, presence: true
  validates_uniqueness_of :placa_veiculo
  validates_format_of :placa_veiculo, with: /[A-Z]{3}-[0-9]{4}/i, create: :on

  def veiculo_upcase
    self.placa_veiculo.upcase!
    self.modelo.upcase!
    self.tipo.upcase!
    self.cor.upcase!
  end
end
