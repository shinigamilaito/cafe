describe("Carrito de Salidas de bodega", function() {
    beforeEach(function() {
        loadFixtures('salidas/salidas_bodega/carrito_salidas_bodega.html');          
    });
    
    it("el div que agrupa el carrito de las salidas debe estar presente", function() {
        
        expect($('.menu-cart-salidas-bodega')).toBeInDOM(); 
        expect($('.menu-cart-salidas-bodega .cart_salida #cancelar-salida-link')[0]).toBeInDOM(); 
        expect($('.menu-cart-salidas-bodega .cart_salida #mensage-error-div')[0]).toBeInDOM(); 
        expect($('.menu-cart-salidas-bodega .cart_salida #realizar-salida-bodega-input')[0]).toBeInDOM(); 
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
        var $salidaBodegaLink = $('.cart_salida #realizar-salida-bodega-input');
        var $divMensajeError = $('#mensage-error-div');
        var spyEvent = spyOnEvent($salidaBodegaLink, 'click');
        
        spyOn(tiposCafe, 'mostrarMensajeError').and.callThrough();
        spyOn(tiposCafe, 'verificarMismoTipo');
        expect($divMensajeError).toHaveCss({display: "none"});
        
        $salidaBodegaLink.click();
        
        expect('click').toHaveBeenTriggeredOn($salidaBodegaLink);
        expect(spyEvent).toHaveBeenTriggered();
        expect(tiposCafe.mostrarMensajeError).toHaveBeenCalled();
        expect(tiposCafe.verificarMismoTipo).toHaveBeenCalled();
        expect($divMensajeError).toHaveCss({display: "block"});
    });
});

describe("Retirar partidas de la bodega", function() {
    beforeEach(function() {
        loadFixtures('salidas/salidas_bodega/carrito_salidas_bodega.html');    
    });
    
    it("Al presionar el enlace salida de Bodega debe mostrarse el formulario", function() {
        var $linkSalidaBodega = $('.card-salida-bodega .salida-bodega');        
        var spyEvent = spyOnEvent($linkSalidaBodega, 'click');
        
        expect($('.card-salida-bodega')[0]).toBeInDOM();
        expect($('.card-salida-bodega .front')[0]).toBeInDOM();
        expect($('.card-salida-bodega .back')[0]).toBeInDOM();
        expect($('.card-salida-bodega .front')).not.toHaveCss({display: "none"});
        expect($('.card-salida-bodega .back')).toHaveCss({display: "none"});
                
        $linkSalidaBodega.click();
        
        expect('click').toHaveBeenTriggeredOn($linkSalidaBodega);
        expect(spyEvent).toHaveBeenTriggered();
//        expect($('.card-salida-proceso .front')).toHaveCss({display: "none"});
        expect($('.card-salida-bodega .back')).not.toHaveCss({display: "none"});
        
    });
    
    it("el formulario debe tener tres inputs", function() {
        expect($('#line_item_salida_bodega_total_sacos')[0]).toBeInDOM();
        expect($('#line_item_salida_bodega_total_bolsas')[0]).toBeInDOM();
        expect($('#line_item_salida_bodega_total_kilogramos_netos')[0]).toBeInDOM();
    });

    it("Las mascaras deben estar definidas", function() {
        expect($('#line_item_salida_bodega_total_sacos')).toHaveMethod('mask');
        expect($('#line_item_salida_bodega_total_bolsas')).toHaveMethod('mask');
        expect($('#line_item_salida_bodega_total_kilogramos_netos')).toHaveMethod('mask');
    });
    
    it("Debe mostrar la animación al momento de sacar la partida de bodega", function() {
      var spyEvent = spyOnEvent($('.card-salida-bodega .add-to-cart'), 'click');
      
      expect($('.menu-cart-salidas-bodega .span_total_partidas')[0]).toBeInDOM();  

      $('.card-salida-bodega .add-to-cart').click();
      
      expect('click').toHaveBeenTriggeredOn($('.card-salida-bodega .add-to-cart'));
      expect(spyEvent).toHaveBeenTriggered(); 
//      expect($('.col-sm-3').length).toEqual(2);
    });
    
});