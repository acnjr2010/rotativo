class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :perfil
  has_many :veiculos
  has_many :vendas
  has_many :bilhetes
  has_many :bilhetepvs
  has_many :orders


  validates :nome, :email, :cpf, :endereco, :telefone, :perfil_id, presence: true
  validates_length_of :cpf, maximum: 14
  validates_length_of :telefone, minimum: 8, maximum: 14
  validates :telefone, numericality: true
  validates_length_of :endereco, in: 10..130
  validates_uniqueness_of :email, :cpf
  validates_format_of :cpf, with: /[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}\-?[0-9]{2}$|^\d[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}\z/, on: :create
end
