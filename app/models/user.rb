class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :veiculos
  has_many :vendas
  has_many :bilhetes
  has_many :bilhetepvs
  belongs_to :perfil

  validates :nome, :email, :cpf, :endereco, :telefone, :perfil_id, presence: true
  validates_cpf :cpf
  validates_length_of :cpf, maximum: 14
  validates_length_of :telefone, minimum: 8, maximum: 14
  validates :telefone, numericality: true
  validates_length_of :endereco, in: 10..130
  validates_uniqueness_of :email, :cpf
  validates_format_of :telefone, with: //, on: :create
  validates_format_of :email, with: //, on: :create
end
