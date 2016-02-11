describe("Registro de entradas", function() {  
  beforeEach(function() {
    loadFixtures('entradas/form_entradas.html');      
  });

  it("el objeto partidas debe estar definido", function() {
     expect(partidas).toBeDefined();          
     expect(partidas.$partidas).toBeArrayOfObjects();
     expect(partidas.$partidas).toBeArrayOfSize(1);
     expect(partidas.$partidas[0]).toBeMatchedBy('.nested-fields');
     expect($totalPartidasBadge.text()).toEqual('1');
  });
  
  it("No mostrar el enlace de eliminar la primer partida", function() {
    expect($('.remove_fields')[0]).not.toBeInDOM();  
  });
  
  it("Permitir agregar mas partidas", function() {
      expect($partidasLink).not.toHaveClass('disabled');            
      
      spyOn(partidas, 'asignarNumero');
      spyOn(partidas, 'actualizarTotalPartidas');
      
      partidas.add(partidas.$partidas[0]);
      
      expect(partidas.asignarNumero).toHaveBeenCalled();
      expect(partidas.asignarNumero).toHaveBeenCalledWith(partidas.$partidas[0]);
      expect(partidas.actualizarTotalPartidas).toHaveBeenCalled();
      expect(partidas.$partidas).toBeArrayOfSize(2);
  });
  
  it("Permitir eliminar partidas", function() {
     spyOn(partidas, 'reordenarNumeros');
     spyOn(partidas, 'actualizarTotalPartidas');
     
     partidas.remove(partidas.$partidas[0]);
     
     expect(partidas.reordenarNumeros).toHaveBeenCalled();
     expect(partidas.actualizarTotalPartidas).toHaveBeenCalled();
     expect(partidas.$partidas).toBeEmptyArray();
     
  });
  
  it("Obtener el total de partidas", function() {
     expect(partidas.size()).toEqual(1);
     
     partidas.add(partidas.$partidas[0]);
     partidas.add(partidas.$partidas[0]);
     partidas.add(partidas.$partidas[0]);
     
     expect(partidas.size()).toEqual(4);
  });
  
  it("Debe asignar numero de partida de forma consecutiva", function() {
      spyOn(partidas, 'obtenerIdentificadorInput').and.callThrough();

      partidas.add(partidas.$partidas[0].clone(true));
      var $nuevaPartida = partidas.$partidas[1];
      partidas.asignarNumero($nuevaPartida);
      
      expect(partidas.obtenerIdentificadorInput).toHaveBeenCalled();
      expect(partidas.obtenerIdentificadorInput).toHaveBeenCalledWith($nuevaPartida);
      expect(partidas.$partidas[0].find('.identificador').eq(0).val()).toEqual('1');
      expect($nuevaPartida.find('.identificador').eq(0).val()).toEqual('2');
  });
  
  it("debe reordenar los numeros", function() {
      spyOn(partidas, 'obtenerIdentificadorInput').and.callThrough();
     
      partidas.reordenarNumeros();
      
      expect(partidas.obtenerIdentificadorInput).toHaveBeenCalled();
  });
  
  it("Debe actualizar el total de partidas", function() {
      partidas.add(partidas.$partidas[0]);
      partidas.add(partidas.$partidas[0]);
      partidas.add(partidas.$partidas[0]);
      
      partidas.actualizarTotalPartidas();
      
      expect($totalPartidasBadge).toContainText('4');
  });
  
  it("Debe responder al evento cocoon:after-insert", function() {
     var spyEvent = spyOnEvent($('#partidas'), 'cocoon:after-insert');
     spyOn(partidas, 'add');
     spyOn(partidas, 'show');
     spyOn(partidas, 'notDeleteFirst');
     
     $('#partidas').trigger('cocoon:after-insert', [$(partidas.$partidas[0])]);
     
      expect('cocoon:after-insert').toHaveBeenTriggeredOn($('#partidas'));
      expect(spyEvent).toHaveBeenTriggered();
      expect(partidas.add).toHaveBeenCalled();
      expect(partidas.show).toHaveBeenCalled();
      expect(partidas.notDeleteFirst).toHaveBeenCalled();
      
  });
  
  it("Debe responder al evento cocoon:before-remove", function() {
     var spyEvent = spyOnEvent($('#partidas'), 'cocoon:before-remove');
     spyOn(partidas, 'remove');
     
     $('#partidas').trigger('cocoon:before-remove', [$(partidas.$partidas[0])]);
     
      expect('cocoon:before-remove').toHaveBeenTriggeredOn($('#partidas'));
      expect(spyEvent).toHaveBeenTriggered();
      expect(partidas.remove).toHaveBeenCalled();
  });  
});  

describe("Debe obtener el valor de la tara", function() {
    
    beforeEach(function() {
        loadFixtures('entradas/form_entradas.html');      
    });
    
    it("El objecto partida debe estar definido", function() {
        expect(partida).toBeDefined();
        expect(partida).toBeObject();
        expect(partida).toHaveMember('$numeroSacos');
        expect(partida).toHaveMember('$numeroBolsas');
        expect(partida).toHaveMember('$tara');
        expect(partida).toHaveMethod('obtenerValorTara');
    });
    
    it("Debe obtener el valor de tara correcto", function() {        
        partida.$numeroSacos = $('.numero-sacos');
        partida.$numeroBolsas = $('.numero-bolsas');
        partida.$tara = $('.tara');
        
        var spyEvent = spyOnEvent(partida.$tara, 'change');
        partida.$numeroSacos.val(25);
        partida.$numeroBolsas.val(5);        
        partida.obtenerValorTara();
        
        expect(partida.$tara.val()).toEqual('25.50');
//        expect('change').toHaveBeenTriggeredOn(partida.$tara);
        expect(spyEvent).toHaveBeenTriggered();
        
        var spyEvent = spyOnEvent(partida.$tara, 'change');
        partida.$numeroSacos.val(57);
        partida.$numeroBolsas.val(68);        
        partida.obtenerValorTara();
        
        expect(partida.$tara.val()).toEqual('63.80');
        expect('change').toHaveBeenTriggeredOn(partida.$tara);
        expect(spyEvent).toHaveBeenTriggered();
    });
    
    it("debe responder al evento keyup para el numero de sacos", function() {
        spyOn(partida, 'obtenerValorTara');
        $('.numero-sacos').keyup(); 
        
        expect(partida.obtenerValorTara).toHaveBeenCalled();
    });
    
    it("debe responder al evento keyup para el numero de bolsas", function() {
        spyOn(partida, 'obtenerValorTara');
        $('.numero-bolsas').keyup(); 
        
        expect(partida.obtenerValorTara).toHaveBeenCalled();
    });
    
});

describe("Debe obtener el valor de los kilogramos netos", function() {
    beforeEach(function() {
        loadFixtures("entradas/form_entradas.html");
    });
    
    it("El objeto partida debe estar definido", function() {
        expect(partida).toBeDefined();
        expect(partida).toBeObject();
        expect(partida).toHaveMember('$kilogramosBrutos');
        expect(partida).toHaveMember('$kilogramosNetos');
        expect(partida).toHaveMember('$tara');
        expect(partida).toHaveMethod('obtenerValorKilogramosNetos'); 
    });
    
    it("debe responder al evento key up sobre kilogramos brutos", function() {
        spyOn(partida, 'obtenerValorKilogramosNetos');
        
        $('.kilogramos-brutos').keyup();
        
        expect(partida.obtenerValorKilogramosNetos).toHaveBeenCalled();
    });
    
     it("debe responder al evento change sobre tara", function() {
        spyOn(partida, 'obtenerValorKilogramosNetos');
        
        $('.tara').change();
        
        expect(partida.obtenerValorKilogramosNetos).toHaveBeenCalled();
    });
    
    it("debe obtener los kilogramos netos de manera correcta", function() {
        partida.$kilogramosBrutos = $('.kilogramos-brutos');
        partida.$tara = $('.tara');
        partida.$kilogramosNetos = $('.kilogramos-netos');
        partida.$kilogramosBrutos.val(350);
        partida.$tara.val(50);        
        partida.obtenerValorKilogramosNetos();
        
        expect(partida.$kilogramosNetos.val()).toEqual('300.00');
        
        partida.$kilogramosBrutos.val(176);
        partida.$tara.val(45.67);        
        partida.obtenerValorKilogramosNetos();
        
        expect(partida.$kilogramosNetos.val()).toEqual('130.33');
    });
    
    describe("Debe configurar el picker fecha, y mask para inputs", function() {
       
        beforeEach(function() {
            loadFixtures("entradas/form_entradas.html");
        });
        
        it("input date debe estar definido", function() {
            expect($('#datetimepicker_for_date')[0]).toBeInDOM();
            expect($('#datetimepicker_for_date')).toHaveMethod('datetimepicker');
            
        });
        
        it("la fecha de la entrada debe tener mascara", function() {
           expect($('#entrada_date')[0]).toBeInDOM(); 
           expect($('#entrada_date')).toHaveMethod('mask');
        });
        
        it("Las mascaras deben estar definidas", function() {
            expect($('.kilogramos-brutos')).toHaveMethod('mask');
            expect($('.tara')).toHaveMethod('mask');
            expect($('.kilogramos-netos')).toHaveMethod('mask');
            expect($('.numero-sacos')).toHaveMethod('mask');
            expect($('.numero-bolsas')).toHaveMethod('mask');
            expect($('.humedad')).toHaveMethod('mask');
        });
    });
    
    describe("Debe obtener el número de entrada por cliente", function() {
        beforeEach(function() {
            loadFixtures("entradas/form_entradas.html");
        });
        
        it("El objeto entrada debe estar definido", function() {
            expect(entrada).toBeDefined();
            expect(entrada).toBeObject();
            expect(entrada).toHaveMember('$idInput');
            expect(entrada).toHaveMember('$clienteInput');
            expect(entrada).toHaveMember('$numeroEntradaClienteInput');
            expect(entrada).toHaveMethod('obtenerValorEntradaCliente'); 
            expect(entrada).toHaveMethod('asignarValorEntrada'); 
            expect(entrada.$idInput).toEqual($('#entrada_id'));
            expect(entrada.$clienteInput).toEqual($('#entrada_client_id'));
            expect(entrada.$numeroEntradaClienteInput).toEqual($('#entrada_numero_entrada_cliente'));
        });
        
        it("Debe asignar el número de entrada al cliente", function() {
            
            entrada.asignarValorEntrada(5);
            
            expect(entrada.$numeroEntradaClienteInput.val()).toEqual('5');
            
            entrada.asignarValorEntrada(2);
            
            expect(entrada.$numeroEntradaClienteInput.val()).toEqual('2');
            
            entrada.asignarValorEntrada();
            
            expect(entrada.$numeroEntradaClienteInput.val()).toEqual('');
            
        });
        
        it("debe obtener el valor de la entrada por cada cambio en el cliente", function() {
            var $entradaCliente = $('#entrada_client_id');
            var spyEvent = spyOnEvent($entradaCliente, 'change');
            spyOn(entrada, 'obtenerValorEntradaCliente');
            
            $entradaCliente.change();
            
            expect('change').toHaveBeenTriggeredOn($entradaCliente);
            expect(spyEvent).toHaveBeenTriggered();
            expect(entrada.obtenerValorEntradaCliente).toHaveBeenCalled();
            
        });
    });
    
    
});