namespace :db do
  desc "Asignando organizaciones a las entradas a partir de las partidas"
  task asignar_organizacion_to_entradas: :environment do
     Entrada.all.each do |entrada|
      entrada.client_id = entrada.partidas.first.client_id
      entrada.save
    end
  end

end
