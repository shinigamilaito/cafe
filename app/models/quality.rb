# == Schema Information
#
# Table name: qualities
#
#  id              :integer          not null, primary key
#  quality_type_id :integer
#  kilos_totales   :string
#  percentage      :string
#  sacos           :integer
#  kilos_sacos     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Quality < ApplicationRecord
  belongs_to :quality_type
  belongs_to :process_result
    
  
end
