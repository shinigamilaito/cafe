class Entrada < ApplicationRecord
  has_many :partidas, dependent: :destroy, inverse_of: :entrada
  accepts_nested_attributes_for :partidas, allow_destroy: true

  validates :date, :numero_entrada, :driver, :entregado_por, presence: :true
  validates :date, uniqueness: {scope: [:numero_entrada]} 
  validates :numero_entrada, uniqueness: true
  
  before_create :siguiente_numero_entrada
  after_save :actualiza_numero_partidas
    
  def siguiente_numero_entrada
    ultima_entrada = Entrada.order("created_at DESC").last
    
    if ultima_entrada
      self.numero_entrada = ultima_entrada.numero_entrada + 1
    else
      self.numero_entrada = 1
    end
  end
  
  def actualiza_numero_partidas        
    self.update_columns(total_partidas: self.partidas.size)
  end
  
end
