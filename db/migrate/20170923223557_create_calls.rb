class CreateCalls < ActiveRecord::Migration[5.0]
  def change
    create_table :calls do |t|
      t.references :from_user, foreign_key: { to_table: :users }
      t.references :to_user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
