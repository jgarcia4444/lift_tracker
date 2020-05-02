class UserLifts < ActiveRecord::Migration
  def change
    create_table :user_lifts do |t|
      t.integer :user_id
      t.integer :lift_type_id
      t.string :weight
    end
  end
end
