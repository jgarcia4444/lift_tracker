class LiftTypes < ActiveRecord::Migration
  def change
    create_table :lift_types do |t|
      t.string :name
    end
  end
end
