# == Schema Information
#
# Table name: salida_procesos
#
#  id                     :integer          not null, primary key
#  client_id              :integer
#  tipo_cafe              :string
#  total_sacos            :integer          default(0)
#  total_bolsas           :integer          default(0)
#  total_kilogramos_netos :string           default("0.0")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class SalidaProcesoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
