class Venda < ActiveRecord::Base
  belongs_to :user
  belongs_to :veiculo
end
