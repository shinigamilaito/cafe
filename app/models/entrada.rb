# == Schema Information
#
# Table name: entradas
#
#  id                     :integer          not null, primary key
#  date                   :datetime
#  numero_entrada         :integer
#  driver                 :string
#  entregado_por          :string
#  total_partidas         :integer          default(1)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  delete_logical         :boolean          default(FALSE)
#  client_id              :integer
#  numero_entrada_cliente :integer          default(0)
#

class Entrada < ApplicationRecord
  scope :validas, -> { where(delete_logical: false) }
  scope :numero_entrada_ascendente, -> { order("numero_entrada ASC") }
  
  has_many :partidas, dependent: :destroy, inverse_of: :entrada  
  accepts_nested_attributes_for :partidas, allow_destroy: true
  belongs_to :client

  validates :date, :numero_entrada, :driver, :entregado_por, presence: :true
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
      self.numero_entrada = 1
    end    
  end
  
  def asignar_numero_entrada_por_cliente
    ultima_entrada = Entrada.where("client_id = ?", self.client_id).order("created_at DESC").first
     if ultima_entrada
      self.numero_entrada_cliente = ultima_entrada.numero_entrada_cliente + 1
    else
      self.numero_entrada_cliente = 1
    end    
  end
  
  def actualiza_numero_partidas        
    self.update_columns(total_partidas: self.total_partidas)
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
  
  # Retorna el número de partidas que estan asociadas 
  # con la entrada
  # return FixNum
  def total_partidas
    return self.partidas.size
  end
  
  # Obtiene los clientes que estan disponibles para las
  # entradas, los cuales se consideran no son historicos,
  # agrega el cliente actual para la entrada actual en caso de que el objecto ya exista
  # return Entrada::ActiveRecord_Relation
  def tipos_clientes
    clients = Client.validos
    
    unless clients.include?(self.client)
      clients = clients.or(Client.where(id: self.client_id))
    end
    
    return clients.order(:organization)
  end
  
  # Verifica si las partidas de esta entrada han salido a proceso o han sido sacados de 
  # la bodega.
  # return Boolean, true si existen partidas con salidas, false contrario
  def tiene_partidas_con_salidas
    ids_partidas_array = partidas.map(&:id)
    existe_salidas_proceso = LineItemSalidaProceso.where(partida_id: ids_partidas_array).present?    
    existe_salidas_bodega = LineItemSalidaBodega.where(partida_id: ids_partidas_array).present?
    
    return existe_salidas_proceso || existe_salidas_bodega
  end
  
  private 
  
    def itera_partidas()
      self.partidas.each { |partida| yield partida }      
    end
  
end
