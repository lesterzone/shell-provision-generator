class CreateProvisions < ActiveRecord::Migration
  def change
    create_table :provisions do |t|
      t.text :script

      t.timestamps null: false
    end
  end
end
