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