//<editor-fold desc="Administra el formulario para el registro de clientes">

function Cliente(options) {
    this.$personaFisica = options.$personaFisica;
    this.$noPersonaFisica = options.$noPersonaFisica;
    this.$representanteLegal = options.$representanteLegal;
    this.$organizacion = options.$organizacion;
    
    $(this.$personaFisica).on('click', this.enabledOrganization.bind(this));       
    $(this.$noPersonaFisica).on('click', this.disabledOrganization.bind(this));       
    $(this.$representanteLegal).on('keyup', this.actualizarOrganizacionTeclado.bind(this));     
}
    
Cliente.prototype.actualizarOrganizacion = function(text) { 
    this.$organizacion.val(text);
    return;
};

Cliente.prototype.enabledOrganization = function() {
    this.$organizacion.attr('readonly', 'readonly');
    this.actualizarOrganizacion(this.$representanteLegal.val());
    return;
};

Cliente.prototype.disabledOrganization = function() {
    this.$organizacion.attr('readonly', null);
    this.actualizarOrganizacion("");

    return;
};

Cliente.prototype.esPersonaFisica = function() {
    return this.$personaFisica.prop("checked");
};

Cliente.prototype.actualizarOrganizacionTeclado = function() {    
    if (this.esPersonaFisica()) {
        this.actualizarOrganizacion(this.$representanteLegal.val());        
    }
    return;
};

var cliente = new Cliente({
    $personaFisica: $("input:radio#client_persona_fisica_true"),
    $noPersonaFisica: $("input:radio#client_persona_fisica_false"),
    $representanteLegal: $('#client_legal_representative'),
    $organizacion: $('#client_organization')
});

//</editor-fold>

//<editor-fold desc="Agrega las salidas de las partidas al proceso">

$(function() {
    if($('.menu-cart-salidas').length) {
        $('.add-to-cart').on('click', function() {            
            var cart = $('.span_total_partidas');
            var imgtodrag = $(this).prev().eq(0);
            var inputwithposition = imgtodrag.prev().eq(0).find('input').eq(0);
            
            if(imgtodrag) {
                var imgclone = imgtodrag.clone();
                
                imgclone.find('h3').eq(0).text(inputwithposition.val());
                
                imgclone
                    .offset({
                    top: inputwithposition.offset().top,
                    left: inputwithposition.offset().left
                })
                    .css({
                    'display': 'block',
                    'opacity': '1',                    
                    'position': 'absolute',
                    'height': '150px',
                    'width': '100px',
                    'z-index': '10'
                })
                    .appendTo($('body'))
                    .animate({
                    'top': cart.offset().top - 5,
                    'left': cart.offset().left + 10,
                    'width': 100,
                    'height': 150
                }, 2000, 'easeInOutBack');
                
                setTimeout(function() {
                    cart.effect("bounce", {
                        times: 2
                    }, 200);
                }, 1500);
                
                imgclone.animate({
                    'width': 0,
                    'height': 0
                }, function() {
                    $(this).detach();
                });
            }
        });
    }
});
//</editor-fold>

//<editor-fold desc="Agrega el efecto flip al retiro de salidas">
$(function() {
    if($('.menu-cart-salidas').length) {
       $(".card").flip({
           trigger: 'manual'
       });     
       
       /**
        * Realiza el cambio de tarjeta para realizar la salida
        */
       
       $('.salida-proceso').click(function() {
           $card = $(this).parents('.card').eq(0);
           $card.flip(true);
       });
    }
});
//</editor-fold>
