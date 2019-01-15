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
    tables = [
      Quality, ProcessResult, Merma, LineItemSalidaBodega, LineItemSalidaProceso,
      CartSalidaBodega, CartSalidaProceso, SalidaBodega, SalidaProceso,
      Partida, Entrada
    ]
    p "Destroying datas"
    tables.each do |table|
      table.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!(table.to_s.pluralize)
    end
    p "Datas destroyed"
  end

  desc "Add the qualities types to process results."
  task add_qualities: :environment do
    p "Adding qualities"
    QualityType.create!(name: "CAFÉ VERDE EXPORTACION", orden: 1)
    QualityType.create!(name: "GRANZA", orden: 2)
    QualityType.create!(name: "TERCERAS DE ZARANDA", orden: 3)
    QualityType.create!(name: "CARACOLILLO", orden: 4)
    QualityType.create!(name: "CEREZO", orden: 5)
    QualityType.create!(name: "TERCERAS DE OLIVER MERCATOR", orden: 6)
    QualityType.create!(name: "MANCHA ELECTRONICA", orden: 7)
    QualityType.create!(name: "BARREDURAS", orden: 8)
    QualityType.create!(name: "PURGA (PERGAMINO)", orden: 9)
    QualityType.create!(name: "MERMA", orden: 10, is_to_increment: false)
  end

end
