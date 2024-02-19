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
require 'rails_helper'

RSpec.describe Apple, type: :model do
  let!(:yellow_color) { create(:color, :yellow_color) }
  let!(:white_color) { create(:color, :white_color) }
  let!(:green_color) { create(:color, :green_color) }

  let!(:shinano_gold) { create(:apple,
                               name: 'シナノゴールド',
                               fruit_color: yellow_color,
                               flower_color: white_color,
                               leaf_color_name: '緑')}

  describe 'fruit_color' do
    it 'ドットで取得できること' do
      p Apple.find_by(name: 'シナノゴールド').fruit_color.name
      actual = Apple.find_by(name: 'シナノゴールド').fruit_color.name
      expect(actual).to eq('黄')
    end

    it 'eager_load + ドットで取得できること' do
      actual = Apple.eager_load(:fruit_color).where(name: 'シナノゴールド' ).first.fruit_color.name
      expect(actual).to eq('黄')
    end

    it 'joins + select で取得できること' do
      actual = Apple.joins(:fruit_color).where(name: 'シナノゴールド').select('colors.name').first
      expect(actual.name).to eq('黄')
    end
  end

  describe 'flower_color' do
    it 'ドットで取得できること' do
      actual = Apple.find_by(name: 'シナノゴールド').flower_color.name
      expect(actual).to eq('白')
    end

    it 'eager_load + ドットで取得できること' do
      actual = Apple.eager_load(:flower_color).where(name: 'シナノゴールド' ).first.flower_color.name
      expect(actual).to eq('白')
    end

    it 'joins + select で取得できること' do
      actual = Apple.joins(:flower_color).where(name: 'シナノゴールド').select('colors.name').first
      expect(actual.name).to eq('白')
    end
  end

  describe 'leaf_color_name' do
    it 'ドットで取得できること' do
      actual = Apple.find_by(name: 'シナノゴールド').leaf_color.name
      expect(actual).to eq('緑')
    end

    it 'eager_load + ドットで取得できること' do
      actual = Apple.eager_load(:leaf_color).where(name: 'シナノゴールド' ).first.leaf_color.name
      expect(actual).to eq('緑')
    end

    it 'joins + select で取得できること' do
      actual = Apple.joins(:leaf_color).where(name: 'シナノゴールド').select('colors.name').first
      expect(actual.name).to eq('緑')
    end

    it 'joins + pluck で取得できること' do
      actual = Apple.joins(:leaf_color).where(name: 'シナノゴールド').pluck('colors.name').first
      expect(actual).to eq('緑')
    end
  end

  describe "applesとcolorsでname列が重複しているときの join系 + select('*')の挙動" do
    context 'eager_loadの時' do
      it 'apple.nameを期待したいが、color.nameになっていること' do
        actual = Apple.eager_load(:fruit_color).where(name: 'シナノゴールド' ).select('*').first

        expect(actual.name).not_to eq('シナノゴールド')
        expect(actual.name).to eq('黄')
      end
    end

    context 'left_joinsの時' do
      it 'apple.nameを期待したいが、color.nameになっていること' do
        actual = Apple.left_joins(:fruit_color).where(name: 'シナノゴールド' ).select('*').first

        expect(actual.name).not_to eq('シナノゴールド')
        expect(actual.name).to eq('黄')
      end
    end

    context 'joinsの時' do
      it 'apple.nameを期待したいが、color.nameになっていること' do
        actual = Apple.joins(:fruit_color).where(name: 'シナノゴールド' ).select('*').first

        expect(actual.name).not_to eq('シナノゴールド')
        expect(actual.name).to eq('黄')
      end
    end
  end
end
