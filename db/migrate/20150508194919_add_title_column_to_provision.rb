class AddTitleColumnToProvision < ActiveRecord::Migration
  def change
    add_column :provisions, :title, :string
  end
end
