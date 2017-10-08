class Client < ApplicationRecord
  scope :validos, -> { where(is_historical: false) }
  
	has_many :entradas

	validates :legal_representative, presence: true
	validates :address, :organization, presence: true  
	validates :legal_representative, uniqueness: {scope: [:organization, :is_historical]} # agregar scope delete logical

  def es_persona_fisica
    self.persona_fisica ? 'Si' : 'No'
  end
  
  def total_entradas
    self.entradas.validas.size
  end
  
  # Si el cliente a actualizar esta siendo referenciado desde alguna entrada
  # se crea un nuevo objeto con los mismos atributos y el cliente
  # actual se mantiene sin cambios a excepción de la bandera is_historical la 
  # cual cambia a verdadero.
  def check_it_is_using_for_another_models(client_params)
    if self.entradas
      new_copy_entrada = self.dup
      self.update(is_historical: true)
      new_copy_entrada.save(client_params)

      new_copy_entrada
    else
      self.update(client_params)
    end
  end
  
end
