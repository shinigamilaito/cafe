describe("Carrito de salidas a proceso", function() {
    beforeEach(function() {
        loadFixtures('salidas/salidas_proceso/carrito_salidas_proceso.html');    
    });
    
    it("el div que agrupa el carrito de las salidas debe estar presente", function() {
        
        expect($('.menu-cart-salidas-proceso')).toBeInDOM(); 
        expect($('.menu-cart-salidas-proceso .cart_salida #cancelar-salida-link')[0]).toBeInDOM(); 
        expect($('.menu-cart-salidas-proceso .cart_salida #mensage-error-div')[0]).toBeInDOM(); 
        expect($('.menu-cart-salidas-proceso .cart_salida #realizar-salida-proceso-input')[0]).toBeInDOM(); 
    });
    
    it("debe estar definido el objeto tipos de café", function() {
        expect(tiposCafe).toBeDefined();
        expect(tiposCafe).toBeObject();
        expect(tiposCafe).toHaveMember('$divErrorMessage');
        expect(tiposCafe).toHaveMember('$tiposCafe');
        expect(tiposCafe).toHaveMethod('verificarMismoTipo');
        expect(tiposCafe).toHaveMethod('mostrarMensajeError');
    });
    
    it("debe verificar que sean del mismo tipo de cafe", function() {
        var $salidaProcesoLink = $('.cart_salida #realizar-salida-proceso-input');
        var $divMensajeError = $('#mensage-error-div');
        var spyEvent = spyOnEvent($salidaProcesoLink, 'click');
        
        spyOn(tiposCafe, 'mostrarMensajeError').and.callThrough();
        spyOn(tiposCafe, 'verificarMismoTipo');
        expect($divMensajeError).toHaveCss({display: "none"});
        
        $salidaProcesoLink.click();
        
        expect('click').toHaveBeenTriggeredOn($salidaProcesoLink);
        expect(spyEvent).toHaveBeenTriggered();
        expect(tiposCafe.mostrarMensajeError).toHaveBeenCalled();
        expect(tiposCafe.verificarMismoTipo).toHaveBeenCalled();
        expect($divMensajeError).toHaveCss({display: "block"});
    });
    
});

describe("Enviar partidas a una salida a proceso", function() {
    beforeEach(function() {
        loadFixtures('salidas/salidas_proceso/carrito_salidas_proceso.html');    
    });
    
    it("Al presionar el enlace salida a proceso debe mostrarse el formulario", function() {
        var $linkSalidaProceso = $('.card-salida-proceso .salida-proceso');        
        var spyEvent = spyOnEvent($linkSalidaProceso, 'click');
        
        expect($('.card-salida-proceso')[0]).toBeInDOM();
        expect($('.card-salida-proceso .front')[0]).toBeInDOM();
        expect($('.card-salida-proceso .back')[0]).toBeInDOM();
        expect($('.card-salida-proceso .front')).not.toHaveCss({display: "none"});
        expect($('.card-salida-proceso .back')).toHaveCss({display: "none"});
                
        $linkSalidaProceso.click();
        
        expect('click').toHaveBeenTriggeredOn($linkSalidaProceso);
        expect(spyEvent).toHaveBeenTriggered();
//        expect($('.card-salida-proceso .front')).toHaveCss({display: "none"});
        expect($('.card-salida-proceso .back')).not.toHaveCss({display: "none"});
        
    });
    
    it("el formulario debe tener tres inputs", function() {
        expect($('#line_item_salida_proceso_total_sacos')[0]).toBeInDOM();
        expect($('#line_item_salida_proceso_total_bolsas')[0]).toBeInDOM();
        expect($('#line_item_salida_proceso_total_kilogramos_netos')[0]).toBeInDOM();
    });

    it("Las mascaras deben estar definidas", function() {
        expect($('#line_item_salida_proceso_total_sacos')).toHaveMethod('mask');
        expect($('#line_item_salida_proceso_total_bolsas')).toHaveMethod('mask');
        expect($('#line_item_salida_proceso_total_kilogramos_netos')).toHaveMethod('mask');
    });
    
    it("Debe mostrar la animación al momento de enviar la partida a proceso", function() {
      var spyEvent = spyOnEvent($('.card-salida-proceso .add-to-cart'), 'click');
      
      expect($('.menu-cart-salidas-proceso .span_total_partidas')[0]).toBeInDOM();  

      $('.card-salida-proceso .add-to-cart').click();
      
      expect('click').toHaveBeenTriggeredOn($('.card-salida-proceso .add-to-cart'));
      expect(spyEvent).toHaveBeenTriggered(); 
//      expect($('.col-sm-3').length).toEqual(2);
    });
    
});