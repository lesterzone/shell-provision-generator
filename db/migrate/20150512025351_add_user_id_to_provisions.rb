class AddUserIdToProvisions < ActiveRecord::Migration
  def change
    add_column :provisions, :user_id, :integer
  end
end
