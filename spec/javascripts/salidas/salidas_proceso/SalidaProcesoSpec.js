describe("Salida a proceso", function() {
    beforeEach(function() {
        loadFixtures('salidas/salidas_proceso/carrito_salidas_proceso.html');          
    });
    
    it("el div que agrupa las salidas a proceso debe estar presente", function() {
        expect($('.menu-cart-salidas-proceso')).toBeInDOM(); 
    });
    
    it("debe agregar a salida los kilos netos, sacos y bolsas", function() {
      var spyEvent = spyOnEvent($('.add-to-cart'), 'click');
      
      expect($('.menu-cart-salidas-proceso .span_total_partidas')[0]).toBeInDOM();  

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
        loadFixtures("salidas/salidas_proceso/tabla_salida_proceso.html");
    });
    
    it("debe estar presente el enlace para realizar la salida", function() {
        expect($('.realizar_salida_proceso_link')[0]).toBeInDOM();
        expect($('.menu-cart-salidas-proceso .cart_salida')[0]).toBeInDOM();
        expect($('.alert')[0]).toBeInDOM();
    });
    
    it("debe estar definido el objeto tipos de café", function() {
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
        loadFixtures("salidas/salidas_proceso/form_salida_proceso.html");
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