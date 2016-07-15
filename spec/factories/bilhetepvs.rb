FactoryGirl.define do
  factory :bilhetepv do
    forma_pagamento 1
    cnpj "MyString"
    placa_veiculo "MyString"
    vendido_por 1
    valor_bilhete 1.5
    setor_id 1
  end
end
