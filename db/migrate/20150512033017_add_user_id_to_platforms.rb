class AddUserIdToPlatforms < ActiveRecord::Migration
  def change
    add_column :platforms, :user_id, :integer
  end
end
