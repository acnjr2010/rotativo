class AddTempoToSetor < ActiveRecord::Migration
  def change
    add_column :setors, :tempo, :integer
  end
end
