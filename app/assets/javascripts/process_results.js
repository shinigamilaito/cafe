//<editor-fold desc="Configuracion de picker hora-fecha">
$(function() {
    
    /**
     * Configuración de picker hora-fecha
     */
    var formatDate = {
        format: "DD/MM/YYYY",
        sideBySide: true,
        ignoreReadonly: true 
    };
    
    $('#process_result_date').parent().datetimepicker(formatDate);
    $('#process_result_fecha_inicio').parent().datetimepicker(formatDate);
    $('#process_result_fecha_termino').parent().datetimepicker(formatDate);
    
    formatDate.format = "HH:mm";
    
    $('#process_result_hora_inicio').parent().datetimepicker(formatDate);
    $('#process_result_hora_termino').parent().datetimepicker(formatDate);
    
});
//</editor-fold>

//<editor-fold desc="Calculo de totales">
$(function() {
    
    var $colsKilogramos = $("input[data-column='kilogramos'");
    var $colsPorcentajes = $("input[data-column='porcentajes'");
    var $colsSacos = $("input[data-column='sacos'");
    var $colsKilogramosSacos = $("input[data-column='kilogramos_sacos'");
    var totalPergamino = Number($('#total-pergamino').val());
    
    $colsKilogramos.keyup(function() {   
        var $currentKilogramosInput = $(this);
        var kilogramos = Number($currentKilogramosInput.val());                        
        var columns = obtainElementsInRow($currentKilogramosInput);
        
        var porcentaje = ((kilogramos / totalPergamino) * 100).toFixed(1);
        var sacos = (kilogramos / 69).toFixed();
        var kilogramosSacos = kilogramos % 69;
        
        columns['saco'].val(sacos);
        columns['porcentaje'].val(porcentaje);
        columns['kilogramosSaco'].val(kilogramosSacos);
        
        calculateTotales($colsKilogramos, $("input[data-column='kilogramos_totales'"));
        calculateTotales($colsPorcentajes, $("input[data-column='porcentajes_totales'"));
        calculateTotales($colsSacos, $("input[data-column='sacos_totales'"));
        calculateTotales($colsKilogramosSacos, $("input[data-column='kilogramos_sacos_totales'"));
        
        $("#process_result_rendimiento").val($("input[data-column='porcentajes_totales'").val() + " %");
        
        return;
    });
});

function obtainTotal(arrValues) {
    return arrValues.reduce(function(total, elem) {
        return total + elem;
    });
}

function obtainElementsInRow($colKilogramos) {
    var $porcentaje = nextInputColumn($colKilogramos.parents(".col-sm-3"));
    var $saco = nextInputColumn($porcentaje.parents(".col-sm-2"));
    var $kilogramosSaco = nextInputColumn($saco.parents(".col-sm-2"));
    
    return {
        'porcentaje': $porcentaje,
        'saco': $saco,
        'kilogramosSaco': $kilogramosSaco
    };
    
    function nextInputColumn($inputColumnParent) {
        return $inputColumnParent.next().find("input");
    }
}

function calculateTotales($columnsArray, $target) {    
    var totalIncrement = 0.0;
    var totalDecrement = 0.0;
    $columnsArray.each(function(index, col) {  
        var $col = $(col);
        if($col.data('increment')) {
            totalIncrement += Number($col.val()); 
        } else {
            totalDecrement += Number($col.val());
        }           
    });
    
    $target.val((totalIncrement - totalDecrement).toFixed(1));
    
    return;
}

//</editor-fold>