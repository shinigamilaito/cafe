class Client < ApplicationRecord
	has_many :partidas

	validates :legal_representative, presence: true
	validates :address, :organization, presence: true
	validates :legal_representative, uniqueness: {scope: [:organization]}

  #before_update :verifica_existencia_partidas
  
  private
  
  def verifica_existencia_partidas
    if partidas
      throw PG::ForeignKeyViolation
    end
  end
end
