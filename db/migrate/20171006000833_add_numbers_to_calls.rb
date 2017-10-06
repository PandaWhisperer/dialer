class AddNumbersToCalls < ActiveRecord::Migration[5.0]
  def change
    add_column :calls, :from_number, :string
    add_column :calls, :to_number, :string
  end
end
