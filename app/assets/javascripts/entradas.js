$(function () {    
    /**
    ** Se agregan las partidas a las entradas
    */
    var $partidasLink = $('.add_fields');
    var partidas = {

        minimum: 1,

        maximum: 30,

        $partidas: [],

        initialize: function() {
            this.$partidas = [];
            var $partidaDiv = $('.nested-fields');            
            var that = this;
            $partidaDiv.each(function(index, partida) {                
                that.$partidas.push($(partida));
            });
            
            return;
        },

        add: function($partida) {            
            this.$partidas.push($partida);
            return;
        },      

        show: function() {            
            this.$partidas.forEach(function($partida) {
                console.log($partida);
            });

            return;
        },

        remove: function($partidaToDestroy) {
            var that = this;
            that.$partidas.forEach(function($partida, index) {
                if ($partida.is($partidaToDestroy)) {
                    that.$partidas.splice(index, 1);
                    return;
                }
                return;
            });
            return;
        },

        notDeleteFirst: function() {
            if (this.$partidas.length !== 0) {
                $removePartidaLink = this.$partidas[0].find('.remove_fields');        
                $removePartidaLink.remove();
            }
            return;
        },

        size: function() {
            return this.$partidas.length;
        }       
    };

    partidas.initialize();
    partidas.show();
    partidas.notDeleteFirst();
    disableAddPartidaLink();

    $('#partidas').on('cocoon:after-insert', function(e, insertedPartida) {

        partidas.add(insertedPartida);
        partidas.show();
        partidas.notDeleteFirst();
        disableAddPartidaLink();

        return;
    });   

    $('#partidas').on('cocoon:before-remove', function(e, deletedPartida) {

        partidas.remove(deletedPartida);        
        if (partidas.size() < partidas.maximum) {
            enableAddPartidaLink($partidasLink);
        }

        return;            
    });   

    function disableAddPartidaLink() {
        if (partidas.size() >= partidas.maximum) {
            disableAddPartidaLink($partidasLink);
        }

        // Private function
        function disableAddPartidaLink($partidasLink) {
            $partidasLink.addClass('disabled');
            return;
        }
    }

    function enableAddPartidaLink($partidasLink) {
        $partidasLink.removeClass('disabled');
        return;
    }
});

$(function() {
    
    /**
     * Objeto que almacena los kilogramos brutos, tara y kilogramos netos
     * @type type
     */    
    var partida = {
        $kilogramosBrutos: null,
        
        $tara: null,
        
        $kilogramosNetos: null,
        
        obtenerValorKilogramosNetos: function() {             
          var difference = this.$kilogramosBrutos.val() - this.$tara.val();  
          return this.$kilogramosNetos.val(difference.toFixed(2));  
        }
    };
    
    /**
     * Funcion que observa por cambios en el campo kilogramos brutos
     */
    $(document).on('keyup', '.kilogramos-brutos', partida, function() {       
        
        var $kilogramosBrutosInput = $(this);
        var $padre = $kilogramosBrutosInput.closest('.nested-fields');
        
        partida.$kilogramosBrutos = $kilogramosBrutosInput;
        partida.$tara = findTara($padre);
        partida.$kilogramosNetos = findKilogramosNetos($padre);
        
        return partida.obtenerValorKilogramosNetos();
    });
    
    /**
     * Funcion que observa por cambios en el campo tara
     */
    $(document).on('keyup', '.tara', partida, function() {       
        
        var $taraInput = $(this);
        var $padre = $taraInput.closest('.nested-fields');
        
        partida.$tara = $taraInput;
        partida.$kilogramosBrutos = findKilogramosBrutos($padre);
        partida.$kilogramosNetos = findKilogramosNetos($padre);
        
        return partida.obtenerValorKilogramosNetos();
    });
    
    function findKilogramosBrutos($padre) {
        var $kilogramosNetosInput = $padre.find('.kilogramos-brutos');
        return $kilogramosNetosInput;
    }
    
    function findTara($padre) {
        var $taraInput = $padre.find('.tara');        
        return $taraInput;
    }
    
    function findKilogramosNetos($padre) {
        var $kilogramosNetosInput = $padre.find('.kilogramos-netos');        
        return $kilogramosNetosInput;
    }
});

$(function() {
    
    /**
     * Configuración de picker hora-fecha
     */
    $('#datetimepicker_for_date').datetimepicker({
        sideBySide: true,
        ignoreReadonly: true
    });
    $('#entrada_date').mask('00/00/0000 00:00');
    
    /**
     * Configuración de mascara para kilogramos brutos, tara,
     * kilogramos netos, numero bultos
     */
    var formatKilogramos = "##0.00";
    var formatBultos = "##0";
    var formatHumedad = "00.00";
    
    $('.kilogramos-brutos').mask(formatKilogramos, {reverse: true});
    addMask($('.container'), ".kilogramos-brutos", formatKilogramos);
    
    $('.tara').mask(formatKilogramos, {reverse: true});
    addMask($('.container'), ".tara", formatKilogramos);
        
    $('.kilogramos-netos').mask(formatKilogramos, {reverse: true});
    addMask($('.container'), ".kilogramos-netos", formatKilogramos);
        
    $('.numero-bultos').mask(formatBultos, {reverse: true});
    addMask($('.container'), ".numero-bultos", formatBultos);
    
    $('.humedad').mask(formatHumedad, {reverse: true});
    addMask($('.container'), ".humedad", formatHumedad);
    
    function addMask($container, element, format) {
        $container.arrive(element, function() {
            var $newElement = $(this);
            $newElement.mask(format, {reverse: true});
        });
    }
    
    
});

/**
 * Entradas Index Controller
 * @returns {undefined}
 */
(function() {
    var app = angular.module('myApp');
    app.controller('entradasIndexController', function($scope) {
        $scope.firstName= "John";
        $scope.lastName= "Doe";
    });
})();