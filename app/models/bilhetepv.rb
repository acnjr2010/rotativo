class Bilhetepv < ActiveRecord::Base
  before_save :veiculo_upcase

  belongs_to :user
  belongs_to :veiculo

  validates :placa_veiculo, :telefone, :setor_id, :periodo, :forma_pagamento, :vendido_por, :status, :ativado_em, :cnpj, presence: true
  validates_length_of :telefone, minimum: 8, maximum: 14
  validates :telefone, numericality: true
  validates_format_of :placa_veiculo, with: /[A-Z]{3}-[0-9]{4}/i, create: :on

  def veiculo_upcase
    self.placa_veiculo.upcase!
  end
end
