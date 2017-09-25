class Client < ApplicationRecord
	has_many :partidas

	validates :name, :first_name, :last_name, presence: true
	validates :address, :organization, presence: true
	validates :name, uniqueness: {scope: [:first_name, :organization]}

  #before_update :verifica_existencia_partidas
  
	def formal_name
		"#{name} #{first_name} #{last_name}"
	end
  
  
  private
  
  def verifica_existencia_partidas
    if partidas
      throw PG::ForeignKeyViolation
    end
  end
end
