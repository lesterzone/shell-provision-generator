class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.string :name
      t.string :codename
      t.string :version
      t.string :install_command

      t.timestamps null: false
    end
  end
end
