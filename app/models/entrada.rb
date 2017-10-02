class Entrada < ApplicationRecord
  scope :validas, -> { where(delete_logical: false) }
  
  has_many :partidas, dependent: :destroy, inverse_of: :entrada  
  accepts_nested_attributes_for :partidas, allow_destroy: true
  belongs_to :client

  validates :date, :numero_entrada, :numero_entrada_cliente, :driver, :entregado_por, presence: :true
  validates :date, uniqueness: {scope: [:numero_entrada]} 
  validates :numero_entrada, uniqueness: true
  validates :client_id, presence: true
  
  before_create :asignar_numero_entrada, :asignar_numero_entrada_por_cliente
  after_save :actualiza_numero_partidas
    
  def asignar_numero_entrada
    ultima_entrada = Entrada.order("created_at DESC").first
    if ultima_entrada
      self.numero_entrada = ultima_entrada.numero_entrada + 1
    else
      return 1
    end    
  end
  
  def asignar_numero_entrada_por_cliente
    ultima_entrada = Entrada.where("client_id = ?", self.client_id).order("created_at DESC").first
     if ultima_entrada
      self.numero_entrada_cliente = ultima_entrada.numero_entrada_cliente + 1
    else
      return 1
    end    
  end
  
  def actualiza_numero_partidas        
    self.update_columns(total_partidas: self.partidas.size)
  end

  def destroyed_logical
    self.update_columns(delete_logical: true)
    return true
  end
  
  def total_kilos_brutos
    total = BigDecimal("0")
    itera_partidas { |partida| total += BigDecimal(partida.kilogramos_brutos) }
        
    total.to_s    
  end
  
  def total_tara
    total = BigDecimal("0")
    itera_partidas { |partida| total += BigDecimal(partida.tara) }
        
    total.to_s    
  end
  
  def total_kilos_netos
    total = BigDecimal("0")
    itera_partidas { |partida| total += BigDecimal(partida.kilogramos_netos) }
        
    total.to_s    
  end
  
  private 
  
    def itera_partidas()
      self.partidas.each { |partida| yield partida }      
    end
  
end
