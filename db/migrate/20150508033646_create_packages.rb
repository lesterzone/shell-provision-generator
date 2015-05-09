class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :version
      t.string :install
      t.references :platform, index: true

      t.timestamps null: false
    end
    add_foreign_key :packages, :platforms
  end
end
