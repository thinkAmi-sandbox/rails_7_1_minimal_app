# == Schema Information
#
# Table name: apples
#
#  id              :integer          not null, primary key
#  leaf_color_name :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  flower_color_id :integer
#  fruit_color_id  :integer
#
# Indexes
#
#  index_apples_on_flower_color_id  (flower_color_id)
#  index_apples_on_fruit_color_id   (fruit_color_id)
#
# Foreign Keys
#
#  flower_color_id  (flower_color_id => colors.id)
#  fruit_color_id   (fruit_color_id => colors.id)
#
class Apple < ApplicationRecord
  # 各リレーションを分かりやすくするため、belongs_to で別名を付けて、 class_name で関連先のモデル名を指定している
  belongs_to :fruit_color, class_name: 'Color', foreign_key: 'fruit_color_id'
  belongs_to :flower_color, class_name: 'Color', foreign_key: 'flower_color_id'

  # name列同士の関連付けをもたせる。なお、DBレイヤーでは外部キー制約にはなっていない。
  belongs_to :leaf_color, class_name: 'Color', foreign_key: 'leaf_color_name', primary_key: 'name'
end
