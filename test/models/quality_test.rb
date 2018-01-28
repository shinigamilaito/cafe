# == Schema Information
#
# Table name: qualities
#
#  id                :integer          not null, primary key
#  quality_type_id   :integer
#  process_result_id :integer
#  kilos_totales     :string
#  percentage        :string
#  sacos             :integer
#  kilos_sacos       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class QualityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
