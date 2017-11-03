describe("Registro de clientes", function() {  
  var $personaFisica;
  var $noPersonaFisica;
  var $representanteLegal;
  var $organizacion;

  beforeEach(function() {
    loadFixtures('clients/form_clientes.html');      
    $personaFisica = $("input:radio#client_persona_fisica_true");
    $noPersonaFisica = $("input:radio#client_persona_fisica_false");
    $representanteLegal = $('#client_legal_representative');
    $organizacion = $('#client_organization');
    
    clienteMock = new Cliente({
        $personaFisica: $personaFisica,
        $noPersonaFisica: $noPersonaFisica,
        $representanteLegal: $representanteLegal,
        $organizacion: $organizacion
    });
  });

  it("verificando que existan los radio button para persona fisica", function() {
     expect($personaFisica[0]).toBeInDOM(); 
     expect($("input:radio#client_persona_fisica_false")[0]).toBeInDOM(); 
  });
  
  it("verificando que existan inputs para representante legal y organizacion", function() {
     expect($representanteLegal[0]).toBeInDOM(); 
     expect($organizacion[0]).toBeInDOM(); 
  });

  it("cliente debe estar presente", function(){
      expect(cliente).toBeDefined();
      expect(cliente).not.toBeNull();
  });

  it("Se debe habilitar la organizacion si es persona fisica", function() {
      spyOn(clienteMock, 'actualizarOrganizacion').and.callThrough();
      var spyEvent = spyOnEvent($personaFisica, 'click');
      
      expect($organizacion).not.toHaveAttr('readonly');  
      
      $representanteLegal.val("XXXXX");
      $personaFisica.click();
      
      expect('click').toHaveBeenTriggeredOn($personaFisica);
      expect(spyEvent).toHaveBeenTriggered();
      expect(clienteMock.actualizarOrganizacion).toHaveBeenCalled();
      expect($organizacion).toHaveAttr('readonly', 'readonly');
      expect($organizacion).toHaveValue("XXXXX");
  });
  
  it("deberia desabilitar la organizacion cuando no es persona fisica", function() {      
      var spyEvent = spyOnEvent($noPersonaFisica, 'click');
      
      $organizacion.val("AAAAA");
      $organizacion.attr('readonly', 'readonly');
      
      expect($organizacion).toHaveAttr('readonly');  
      expect($organizacion).toHaveValue("AAAAA");
      
      $noPersonaFisica.click();
      
      expect('click').toHaveBeenTriggeredOn($noPersonaFisica);
      expect(spyEvent).toHaveBeenTriggered();
      expect($organizacion).not.toHaveAttr('readonly');
      expect($organizacion).toHaveValue("");
      
  });
  
  it("debe tener el mismo representante legal y organizacion si es persona fisica", function() {
      var spyEvent = spyOnEvent($representanteLegal, 'keyup');
      
      $noPersonaFisica.click();      
      $representanteLegal.val("AAAAA");      
      
      expect($representanteLegal).toHaveValue("AAAAA");      
      expect($noPersonaFisica).toBeChecked();
      
      $representanteLegal.keyup();
      
      expect('keyup').toHaveBeenTriggeredOn($representanteLegal);
      expect(spyEvent).toHaveBeenTriggered();
      expect($organizacion).toHaveValue("");
      
  });  
});

describe("Salida a proceso", function() {
    beforeEach(function() {
        loadFixtures('clients/carrito_salidas_proceso.html');          
    });
    
    it("el div que agrupa las salidas a proceso debe estar presente", function() {
        expect($('.menu-cart-salidas')).toBeInDOM(); 
    });
    
    it("debe agregar a salida los kilos netos, sacos y bolsas", function() {
      var spyEvent = spyOnEvent($('.add-to-cart'), 'click');
      
      expect($('.span_total_partidas')[0]).toBeInDOM();  

       $('.add-to-cart').click();
      
      expect('click').toHaveBeenTriggeredOn($('.add-to-cart'));
      expect(spyEvent).toHaveBeenTriggered(); 
      expect($('.col-sm-3').length).toEqual(2);
    });
    
    it("Debe realizar el efecto flip", function() {
        var spyEvent = spyOnEvent($('.salida-proceso'), 'click');
        
        $('.salida-proceso').click();
        
        expect('click').toHaveBeenTriggeredOn($('.salida-proceso'));
        expect(spyEvent).toHaveBeenTriggered();
        
    });
});

describe("Cuando se realize una salida a proceso", function() {
    beforeEach(function() {
        loadFixtures("clients/tabla_salida_proceso.html");
    });
    
    it("debe estar presente el enlace para realizar la salida", function() {
        expect($('.realizar_salida_proceso_link')[0]).toBeInDOM();
        expect($('.cart_salida')[0]).toBeInDOM();
        expect($('.alert')[0]).toBeInDOM();
    });
    
    it("debe estar definido el objeto salida a proceso", function() {
        expect(tiposCafe).toBeDefined();
        expect(tiposCafe).toBeObject();
        expect(tiposCafe).toHaveMember('$tiposCafe');
        expect(tiposCafe).toHaveMethod('verificarMismoTipo');
        expect(tiposCafe).toHaveMethod('mostrarMensajeError');
    });
    
    it("debe verificar que sean del mismo tipo de cafe", function() {
        var $salidaProcesoLink = $('.realizar_salida_proceso_link');
        var spyEvent = spyOnEvent($salidaProcesoLink, 'click');
        spyOn(tiposCafe, 'mostrarMensajeError').and.callThrough();
        spyOn(tiposCafe, 'verificarMismoTipo');
        expect($('.alert')).toHaveCss({display: "none"});
        $salidaProcesoLink.click();
        
        expect('click').toHaveBeenTriggeredOn($salidaProcesoLink);
        expect(spyEvent).toHaveBeenTriggered();
        expect(tiposCafe.mostrarMensajeError).toHaveBeenCalled();
        expect(tiposCafe.verificarMismoTipo).toHaveBeenCalled();
        expect($('.alert')).toHaveCss({display: "block"});
    });
});

//<editor-fold desc="Verifica la colocación de las mascaras en el formulario de salida a proceso">

describe("El formulario para las salidas a proceso debe tener mascaras en los input", function() {
       
    beforeEach(function() {
        loadFixtures("clients/form_salida_proceso.html");
    });

    it("el formulario debe tener tres inputs", function() {
        expect($('#line_item_salida_total_sacos')[0]).toBeInDOM();
        expect($('#line_item_salida_total_bolsas')[0]).toBeInDOM();
        expect($('#line_item_salida_total_kilogramos_netos')[0]).toBeInDOM();
    });

    it("Las mascaras deben estar definidas", function() {
        expect($('#line_item_salida_total_sacos')).toHaveMethod('mask');
        expect($('#line_item_salida_total_bolsas')).toHaveMethod('mask');
        expect($('#line_item_salida_total_kilogramos_netos')).toHaveMethod('mask');
    });
    
});

//</editor-fold>