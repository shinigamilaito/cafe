# == Schema Information
#
# Table name: line_item_salidas
#
#  id                     :integer          not null, primary key
#  partida_id             :integer
#  cart_salida_id         :integer
#  total_sacos            :integer          default(0)
#  total_bolsas           :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  total_kilogramos_netos :string           default("0.00")
#  salida_proceso_id      :integer
#

class LineItemSalida < ApplicationRecord
  belongs_to :salida_proceso, optional: true
  belongs_to :partida
  belongs_to :cart_salida, optional: true
  
  validates :partida_id, presence: true
  validates :total_sacos, :total_bolsas, :total_kilogramos_netos, presence: true
  validates :total_sacos, :total_bolsas, numericality: { only_integer: true }, format:{with: /\A\d+\z/ }  
  validates :total_kilogramos_netos, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }  
  validate :check_total_sacos_is_valid, :check_total_bolsas_is_valid, :check_total_kilogramos_netos_is_valid
  
  def cliente
    self.partida.entrada.client
  end
  
  # Verifica si el total de sacos es menor o igual a la cantidad disponible en la partida
  # la cantidad disponible es el total de sacos en la partida menos la cantida de sacos
  # que han salida a proceso
  # return true | false
  # Si es false agrega un mensaje de error al objeto errors de la partida
  def check_total_sacos_is_valid
    sacos_disponibles = partida.total_sacos_disponibles
    if sacos_disponibles >= total_sacos
      return true
    else
      errors.add(:total_sacos, "La cantidad disponible es #{sacos_disponibles} sacos")
      return false
    end
  end
  
  # Verifica si el total de bolsas es menor o igual a la cantidad disponible en la partida
  # la cantidad disponible es el total de bolsas en la partida menos la cantidad de bolsas
  # que han salida a proceso
  # return true | false
  # Si es false agrega un mensaje de error al objeto errors de la salida
  def check_total_bolsas_is_valid
    bolsas_disponibles = partida.total_bolsas_disponibles
    if bolsas_disponibles >= total_bolsas
      return true
    else
      errors.add(:total_bolsas, "La cantidad disponible es #{bolsas_disponibles} bolsas")
      return false
    end
  end
  
  # Verifica si el total de kilos es menor o igual a la cantidad disponible en la partida
  # la cantidad disponible es el total de kilos en la partida menos la cantidad de kilos
  # que han salida a proceso
  # return true | false
  # Si es false agrega un mensaje de error al objeto errors de la salida
  def check_total_kilogramos_netos_is_valid
    kilos_disponibles = partida.total_kilos_netos_disponibles
    if kilos_disponibles >= BigDecimal(total_kilogramos_netos)
      return true
    else
      errors.add(:total_kilogramos_netos, "La cantidad disponible es #{kilos_disponibles} kilogramos")
      return false
    end
  end
end
