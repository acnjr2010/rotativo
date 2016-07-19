class AddFormaPagtoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :forma_pagto, :integer
  end
end
