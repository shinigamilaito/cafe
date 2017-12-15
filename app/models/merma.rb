# == Schema Information
#
# Table name: mermas
#
#  id           :integer          not null, primary key
#  merma_type   :integer          default("dry_coffee")
#  date_dry     :date
#  quantity     :string
#  observations :text
#  partida_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Merma < ApplicationRecord
  enum merma_type: { dry_coffee: 0, time: 1, sample_coffee: 2 }  
  
  belongs_to :partida

  validates :merma_type, inclusion: { in: Merma.merma_types }  
  validates :quantity, :partida, presence: true
  validates :date_dry, presence: true, if: Proc.new { |m| m.merma_type == "dry_coffee" }  
  validates :quantity, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }
  
end
