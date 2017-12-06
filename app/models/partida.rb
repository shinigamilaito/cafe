# == Schema Information
#
# Table name: partidas
#
#  id                :integer          not null, primary key
#  identificador     :integer          default(1)
#  entrada_id        :integer
#  kilogramos_brutos :string
#  numero_sacos      :integer
#  tara              :string
#  kilogramos_netos  :string
#  humedad           :string
#  type_coffee_id    :integer
#  calidad_cafe      :string
#  observaciones     :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  numero_bolsas     :integer
#

class Partida < ApplicationRecord
  scope :identificador_ascendente, -> { order("identificador ASC") }
  
  belongs_to :entrada    
  belongs_to :type_coffee  
  has_many :line_item_salida_procesos
  has_many :line_item_salida_bodegas
  has_many :mermas

  validates :kilogramos_brutos, :numero_bolsas, :numero_sacos, presence: true
  validates :tara, :kilogramos_netos, :humedad, presence: true
  validates :type_coffee_id, :calidad_cafe, presence: true
  validates :numero_bolsas, :numero_sacos, numericality: { only_integer: true }, format:{with: /\A\d+\z/ }  
  validates :kilogramos_brutos, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }
  validates :tara, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }
  validates :kilogramos_netos, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }  
  validates :humedad, allow_blank: true, numericality: {
    greater_than_or_equal_to: 10, less_than_or_equal_to: 20 }  
  
  before_save :verificar_valor_tara
  before_save :verificar_valor_kilogramos_netos  
  before_destroy :ensure_not_referenced_by_any_line_item_salida
  
  # Obtiene los tipos de cafe que estan disponibles para las
  # partidas, los cuale se consideran no son historicos
  # agrega el tipo de cafe actual en caso de que el objecto ya exista
  # return TypeCoffee::ActiveRecord_Relation
  def tipos_cafes
    type_coffees = TypeCoffee.validos
    
    unless type_coffees.include?(self.type_coffee)
      type_coffees = type_coffees.or(TypeCoffee.where(id: self.type_coffee_id))
    end
    
    return type_coffees.order(:name)
  end
  
  # Devuelve el total de sacos que han tenido salidas a proceso
  # return Integer mayor o igual a cero
  def total_sacos_a_proceso
    salidas_proceso.map(&:total_sacos).sum   
  end
  
  # Devuelve el total de sacos que han sacado de bodega
  # return Integer mayor o igual a cero
  def total_sacos_de_bodega
    salidas_de_bodega.map(&:total_sacos).sum   
  end
  
  # Devuelve el total de bolsas que han tenido salidas a proceso
  # return Integer mayor o igual a cero
  def total_bolsas_a_proceso
    salidas_proceso.map(&:total_bolsas).sum
  end
  
  # Devuelve el total de bolsas que han sacado de bodega
  # return Integer mayor o igual a cero
  def total_bolsas_de_bodega
    salidas_de_bodega.map(&:total_bolsas).sum
  end
  
  # Devuelve el total de kilos netos que han tenido salidas a proceso
  # return String
  def total_kilos_netos_a_proceso
    total_kilos_netos = BigDecimal('0')
    salidas_proceso.each do |salida|  
      total_kilos_netos += BigDecimal("#{salida.total_kilogramos_netos}") 
    end
    
    return total_kilos_netos.to_s
  end
  
  # Devuelve el total de kilos netos que han sacado de bodega
  # return String
  def total_kilos_netos_de_bodega
    total_kilos_netos = BigDecimal('0')
    salidas_de_bodega.each do |salida|  
      total_kilos_netos += BigDecimal("#{salida.total_kilogramos_netos}") 
    end
    
    return total_kilos_netos.to_s
  end
  
  # Devuelve el total de kilos mermados
  # Return String
  def total_mermas
    total_mermas = BigDecimal('0')
    
    return (mermas.map() { |m| BigDecimal(m.quantity) }).sum().to_s
  end
  
  # Devuelve la cantidad de sacos disponibles
  # return Integer mayor o igual a cero
  def total_sacos_disponibles
    return numero_sacos - (total_sacos_a_proceso + total_sacos_de_bodega)
  end
  
  # Devuelve la cantidad de bolsas disponibles
  # return Integer mayor o igual a cero
  def total_bolsas_disponibles
    return numero_bolsas - (total_bolsas_a_proceso + total_bolsas_de_bodega)
  end
  
  # Devuelve la cantidad de kilos netos disponibles
  # return Big Decimal mayor o igual a cero
  def total_kilos_netos_disponibles
    total_kilos_sacados = BigDecimal(total_kilos_netos_a_proceso) + BigDecimal(total_kilos_netos_de_bodega)
    total_mermas_partida = BigDecimal(total_mermas)
    
    return BigDecimal(kilogramos_netos) - (total_kilos_sacados + total_mermas_partida) 
  end

  private
  
    def verificar_valor_tara
      valor_real_tara = self.numero_sacos + self.numero_bolsas*0.100
      valor_actual_tara = self.tara
      
      if (valor_real_tara != valor_actual_tara) 
        self.errors.add(:tara, 'El valor no corresponde a la diferencia entre sacos y bolsas')
      end
      
    end
    
    def verificar_valor_kilogramos_netos
      valor_real_kilogramos_netos = self.kilogramos_brutos.to_f - self.tara.to_f
      valor_actual_kilogramos_netos = self.kilogramos_netos
      
      if (valor_real_kilogramos_netos != valor_actual_kilogramos_netos) 
        self.errors.add(:kilogramos_netos, 'El valor no corresponde a la diferencia entre kilogramos brutos y tara')
      end
    end
    
    # ensure that there are no line items referencing this partida
    def ensure_not_referenced_by_any_line_item_salida
      unless line_item_salida_procesos.empty?
        errors.add(:base, 'hay salidas presentes')
        throw :abort
      end
    end
    
    # Obtiene las salidas a proceso
    # Return ActiveRecord::Relation LineItemSalidaProceso
    def salidas_proceso
      return line_item_salida_procesos.where("salida_proceso_id IS NOT NULL")
    end
    
    # Obtiene las salidas de bodega
    # Return ActiveRecord::Relation LineItemSalidaBodega
    def salidas_de_bodega
      return line_item_salida_bodegas.where("salida_bodega_id IS NOT NULL")
    end
end
