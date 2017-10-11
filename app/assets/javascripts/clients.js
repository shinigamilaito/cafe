$(function() {
    
    if($('#formulario-clientes').length) {        
        /**
         * Objeto que almacena persona fisica, representante legal y organizacion
         * @type type
         */    
        var cliente = {
            $personaFisica: $("input:radio[value='true']"),

            $representanteLegal: $('#client_legal_representative'),

            $organizacion: $('#client_organization'),

            actualizarOrganizacion: function() {             
                if(this.esPersonaFisica()) {
                    this.$organizacion.val(this.$representanteLegal.val());
                }
                return;
            },
            
            enabledDisabledOrganization: function() {
                if(this.esPersonaFisica()) {
                    this.$organizacion.attr('readonly', 'readonly');
                } else {
                    this.$organizacion.attr('readonly', null);
                }
            },
            
            esPersonaFisica: function() {
                return this.$personaFisica.prop("checked");
            }
        };
        
        cliente.enabledDisabledOrganization();
        
        /**
         * Funcion que observa por cambios en el campo representante legal
         */
        $(document).on('keyup', '#client_legal_representative', cliente, function() {     
            cliente.actualizarOrganizacion();
            return;
        });

        /**
         * Funcion que observa por cambios en el campo persona fisica
         */
        $(document).on('click', "input:radio[name='client[persona_fisica]']", cliente, function() {       

            cliente.enabledDisabledOrganization();
            cliente.actualizarOrganizacion();
            
            return;
        });

    }
    
});

/**
 * Agrega el elemento al carrito de salidas
 */

$(function() {
    if($('._menu-cart-salidas').length) {
        $('.add-to-cart').on('click', function() {
            var cart = $('#span_total_partidas');
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

/**
 * Agrega el effecto flip al retiro de salidas
 */

$(function() {
    if($('._menu-cart-salidas').length) {
       $(".card").flip({
           trigger: 'manual'
       });     
       
       
       /**
        * Realiza el cambio de tarjeta para realizar la salida
        */
       
       $('._salida-proceso').click(function() {
           $card = $(this).parents('.card').eq(0);
           $card.flip(true);
       });
    }
    
    
});