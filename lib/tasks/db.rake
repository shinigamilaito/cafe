namespace :db do
  desc "Asignando organizaciones a las entradas a partir de las partidas"
  task asignar_organizacion_to_entradas: :environment do
     Entrada.all.each do |entrada|
      entrada.client_id = entrada.partidas.first.client_id
      entrada.save
    end
  end
  
  desc "Asignando numero de entradas por cliente a las entradas ya registradas"
  task asignar_numero_entrada_por_organizacion_to_entradas: :environment do
     Client.all.each do |cliente|
       cliente.entradas.order("id ASC").each_with_index do |entrada, index|
         entrada.numero_entrada_cliente = index + 1
         entrada.save
       end      
    end
  end
  
  desc "Cleaning the system. Only clients and type_coffees will exist."
  task cleaning_tables: :environment do
    p "Destroying datas"
    Merma.destroy_all
    LineItemSalidaBodega.destroy_all
    LineItemSalidaProceso.destroy_all
    CartSalidaBodega.destroy_all
    CartSalidaProceso.destroy_all
    SalidaBodega.destroy_all
    SalidaProceso.destroy_all
    Partida.destroy_all    
    Entrada.destroy_all
    p "Datas destroyed"
  end

end
