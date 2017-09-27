class Entrada < ApplicationRecord
  scope :validas, -> { where(delete_logical: false) }
  
  has_many :partidas, dependent: :destroy, inverse_of: :entrada  
  accepts_nested_attributes_for :partidas, allow_destroy: true
  belongs_to :client

  validates :date, :numero_entrada, :driver, :entregado_por, presence: :true
  validates :date, uniqueness: {scope: [:numero_entrada]} 
  validates :numero_entrada, uniqueness: true
  validates :client_id, presence: true
  
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
  
  def destroyed_logical
    self.update_columns(delete_logical: true)
    return true
  end
  
end
