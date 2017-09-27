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
