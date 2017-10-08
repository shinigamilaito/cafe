class TypeCoffee < ApplicationRecord
  scope :validos, -> { where(is_historical: false) }
  
	has_many :partidas
  
  validates :name, presence: true
  validates :name, uniqueness: true
  
  before_update :check_it_is_using_for_another_models
  
  private

    # Si el tipo de cafe a actualizar esta siendo referenciado desde alguna partida
    # se crea un nuevo objeto con los mismos atributos y el tipo de cafe
    # actual se mantiene sin cambios a excepcinó de la bandera is_historical la 
    # cual cambia a verdadero.
    def check_it_is_using_for_another_models
      if self.partidas
        new_copy_type_coffee = self.dup
        new_copy_type_coffee.save
        self.reload     
        self.is_historical = true
      end
    end
end
