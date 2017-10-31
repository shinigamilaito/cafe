# == Schema Information
#
# Table name: clients
#
#  id                   :integer          not null, primary key
#  legal_representative :string
#  address              :text
#  organization         :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  persona_fisica       :boolean          default(FALSE)
#  is_historical        :boolean          default(FALSE)
#  delete_logical       :boolean          default(FALSE)
#

class Client < ApplicationRecord
  scope :validos, -> { where('is_historical = ? AND delete_logical = ?', false, false) }
  
	has_many :entradas

	validates :legal_representative, presence: true
	validates :address, :organization, presence: true  
	validates :organization, uniqueness: {scope: [:is_historical, :delete_logical]}
	validates :legal_representative, uniqueness: {scope: [:is_historical, :delete_logical]}

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
    unless self.entradas.blank?
      self.update(is_historical: true)
      
      new_copy_client = Client.new(client_params)      
      new_copy_client.save
      new_copy_client
      
    else
      self.update(client_params)
      self
    end
  end
  
  def destroyed_logical
    self.update_columns(delete_logical: true)
    return true
  end
  
end
