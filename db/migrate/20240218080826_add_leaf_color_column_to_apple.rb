class AddLeafColorColumnToApple < ActiveRecord::Migration[7.1]
  def change
    add_column :apples, :leaf_color_name, :string
  end
end
