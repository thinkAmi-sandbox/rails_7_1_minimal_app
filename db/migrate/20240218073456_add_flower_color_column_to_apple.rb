class AddFlowerColorColumnToApple < ActiveRecord::Migration[7.1]
  def change
    add_reference :apples, :flower_color, foreign_key: { to_table: :colors }
  end
end
