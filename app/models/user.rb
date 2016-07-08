class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :veiculos
  has_many :vendas

  validates :nome, :email, :cpf, :endereco, :telefone, presence: true
  validates_cpf :cpf
  validates_length_of :cpf, maximum: 14
  validates_length_of :telefone, minimum: 10, maximum: 13
  validates_length_of :endereco, in: 10..130
  validates_uniqueness_of :email, :cpf
  validates_format_of :telefone, with: //, on: :create
  validates_format_of :email, with: //, on: :create
end
