class TypeCoffee < ApplicationRecord
  scope :validos, -> { where(is_historical: false) }
  
	has_many :partidas
  
  validates :name, presence: true
  validates :name, uniqueness: {scope: [:is_historical]}
  
  # Si el tipo de cafe a actualizar esta siendo referenciado desde alguna partida
  # se crea un nuevo objeto con los mismos atributos y el tipo de cafe
  # actual se mantiene sin cambios a excepción de la bandera is_historical la 
  # cual cambia a verdadero.
  def check_it_is_using_for_another_models(type_coffee_params)
    unless self.partidas.blank?
      self.update(is_historical: true)
      
      new_copy_type_coffee = TypeCoffee.new(type_coffee_params)
      new_copy_type_coffee.save
      new_copy_type_coffee
      
    else
      self.update(type_coffee_params)
      self
    end
  end
  
end
