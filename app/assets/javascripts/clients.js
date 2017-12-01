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

//<editor-fold desc="Código para el manejo del carrito de salidas a proceso">

//<editor-fold desc="Verifica que el tipo de cafe sea el mismo antes de realizar la salida">

var tiposCafe = {
    
  $divErrorMessage: null,
    
  $tiposCafe: [],
  
  mismoTipo: false,
  
  verificarMismoTipo: function() {
    var mismoTipoCafe = true;
    var tipoCafe = '';
    this.$tiposCafe.each(function(index, element) {        
        if(index === 0) {
            tipoCafe = $(element).text();
        } else {
            if (tipoCafe !== $(element).text()) {
                mismoTipoCafe = false;
                return;
            } 
        }
    }); 
    
    this.mismoTipo = mismoTipoCafe;
    return mismoTipoCafe;
  },
  
  mostrarMensajeError: function() {
      if(this.verificarMismoTipo()) {          
          $('.alert').css({display: 'none'});
      } else {          
          $('.alert').css({display: 'block'});
      }
  }
  
};

$(function() {
    $('.menu-cart-salidas-proceso').on('click', '.cart_salida #realizar-salida-proceso-input', function(e) {        
        var $link = $(this);
        var $panelFooter = $link.parents('.panel-footer');
        tiposCafe.$divErrorMessage = $panelFooter.find('#mensage-error-div');
        var $tiposCafe = $panelFooter.prev().find('.tipo_cafe_salida');
        tiposCafe.$tiposCafe = $tiposCafe;
        tiposCafe.mostrarMensajeError();
        if (tiposCafe.mismoTipo) {
            return true;
        } else {
            return false;            
        }
    });    
});

//</editor-fold>

//</editor-fold>

//<editor-fold desc="Contiene los datos relacionados con las partidas que salen a proceso">

//<editor-fold desc="Agrega el efecto flip al enlace que muestra el formulatio de salidas a proceso">
$(function() {
    if($('.menu-cart-salidas-proceso').length) {
       $(".card-salida-proceso").flip({
           trigger: 'manual'
       });     
       
       /**
        * Realiza el cambio de tarjeta para realizar la salida a proceso
        */
       
       $('.card-salida-proceso .salida-proceso').click(function() {
           $card = $(this).parents('.card-salida-proceso').eq(0);
           $card.flip(true);
           $card.find('.back').css({display: 'block'});
       });
    }
});
//</editor-fold>

//<editor-fold desc="Coloca las mascaras a los input del formulario de salida a proceso">
$(function() {
    
    var formatKilogramos = "##0.00";
    var formatSacosBolsas = "##0";    
    
    $('#line_item_salida_proceso_total_kilogramos_netos').mask(formatKilogramos, {reverse: true});
    
    $('#line_item_salida_proceso_total_bolsas').mask(formatSacosBolsas, {reverse: true});
        
    $('#line_item_salida_proceso_total_sacos').mask(formatSacosBolsas, {reverse: true});
        
});

//</editor-fold>

//<editor-fold desc="Agrega el efecto que muestra la imagen del cafe a las partidas que han salido a proceso">

$(function() {
    if($('.menu-cart-salidas-proceso').length) {
        $('.card-salida-proceso .add-to-cart').on('click', function() {            
            var cart = $(this).parents('.wrapper_partida_tabs').prev().find('.menu-cart-salidas-proceso .span_total_partidas');            
            var imgtodrag = $(this).prev().eq(0);
//            var imgtodrag = $(this).prev().find('img');
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
                    'height': '100px',
                    'width': '150px',
                    'z-index': '10'
                })
                    .appendTo($('body'))
                    .animate({
                    'top': cart.offset().top - 5,
                    'left': cart.offset().left + 10,
                    'width': 100,
                    'height': 50
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

//</editor-fold>

