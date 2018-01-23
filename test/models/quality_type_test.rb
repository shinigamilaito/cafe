# == Schema Information
#
# Table name: quality_types
#
#  id              :integer          not null, primary key
#  name            :string
#  orden           :integer          default(1)
#  is_to_increment :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class QualityTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
