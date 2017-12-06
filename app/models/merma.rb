# == Schema Information
#
# Table name: mermas
#
#  id           :integer          not null, primary key
#  date_dry     :date
#  quantity     :string
#  observations :text
#  partida_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Merma < ApplicationRecord
  belongs_to :partida
  
  validates :date_dry, :quantity, :partida, presence: true
  validates :quantity, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }
end
