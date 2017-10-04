class Client < ApplicationRecord
	has_many :entradas

	validates :legal_representative, presence: true
	validates :address, :organization, presence: true  
	validates :legal_representative, uniqueness: {scope: [:organization]}

  #before_update :verifica_existencia_partidas
  
  def es_persona_fisica
    self.persona_fisica ? 'Si' : 'No'
  end
  
  def total_entradas
    self.entradas.validas.size
  end
  
  private
  
  def verifica_existencia_partidas
    if partidas
      throw PG::ForeignKeyViolation
    end
  end
end
