class Partida < ApplicationRecord
  belongs_to :entrada    
  belongs_to :type_coffee

  validates :kilogramos_brutos, :numero_bultos, presence: true
  validates :tara, :kilogramos_netos, :humedad, presence: true
  validates :type_coffee_id, :calidad_cafe, presence: true
  validates :kilogramos_brutos, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }
  validates :tara, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }
  validates :kilogramos_netos, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }  
  validates :humedad, allow_blank: true, numericality: {
    greater_than_or_equal_to: 10, less_than_or_equal_to: 20 }  
  
  
end
