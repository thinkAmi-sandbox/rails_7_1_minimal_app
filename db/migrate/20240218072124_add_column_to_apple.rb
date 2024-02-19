class AddColumnToApple < ActiveRecord::Migration[7.1]
  def change
    add_reference :apples, :fruit_color, foreign_key: { to_table: :colors }
  end
end
