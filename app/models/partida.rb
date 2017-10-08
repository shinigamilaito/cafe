class Partida < ApplicationRecord
  scope :identificador_ascendente, -> { order("identificador ASC") }
  
  belongs_to :entrada    
  belongs_to :type_coffee

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
  
  # Obtiene los tipos de cafe que estan disponibles para las
  # partidas, los cuale se consideran no son historicos
  # agrega el tipo de cafe actual en caso de que el objecto ya exista
  # return TypeCoffee::ActiveRecord_Relation
  def tipos_cafes
    type_coffees = TypeCoffee.validos
    if self.new_record?
      return type_coffees
    else
      return type_coffees +  TypeCoffee.where(id: self.type_coffee_id)
    end
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
    
end
