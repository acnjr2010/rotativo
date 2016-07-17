class Order < ActiveRecord::Base
  belongs_to :produto
  belongs_to :user
end
