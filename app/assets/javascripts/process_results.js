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
    $('#process_result_fecha_inicio_humedad').parent().datetimepicker(formatDate);
    $('#process_result_fecha_termino_humedad').parent().datetimepicker(formatDate);
    
});
//</editor-fold>

//<editor-fold desc="Calculo de totales">
$(function() {
    
    var $colsKilogramos = $("input[data-column='kilogramos'");
    var $colsPorcentajes = $("input[data-column='porcentajes'");
    var $colsSacos = $("input[data-column='sacos'");
    var $colsKilogramosSacos = $("input[data-column='kilogramos_sacos'");
    
    $colsKilogramos.keyup(function() {        
        var valuesIncrement = [];
        var valuesDecrement = [];
               
        $colsKilogramos.each(function(index, col) {
            
            if($(col).data('increment')) {
                valuesIncrement.push(Number($(col).val())); 
            } else {
                valuesDecrement.push(Number($(col).val()));
            }           
        });
        
        $("input[data-column='kilogramos_totales'")
                .val(obtainTotal(valuesIncrement) - obtainTotal(valuesDecrement));
        
        return;
    });
    
    $colsPorcentajes.keyup(function() {        
        var valuesIncrement = [];
        var valuesDecrement = [];
               
        $colsPorcentajes.each(function(index, col) {
            
            if($(col).data('increment')) {
                valuesIncrement.push(Number($(col).val())); 
            } else {
                valuesDecrement.push(Number($(col).val()));
            }           
        });
        
        $("input[data-column='porcentajes_totales'")
                .val(obtainTotal(valuesIncrement) - obtainTotal(valuesDecrement));
        
        return;
    });
    
    $colsSacos.keyup(function() {        
        var valuesIncrement = [];
        var valuesDecrement = [];
               
        $colsSacos.each(function(index, col) {
            
            if($(col).data('increment')) {
                valuesIncrement.push(Number($(col).val())); 
            } else {
                valuesDecrement.push(Number($(col).val()));
            }           
        });
        
        $("input[data-column='sacos_totales'")
                .val(obtainTotal(valuesIncrement) - obtainTotal(valuesDecrement));
        
        return;
    });
    
    $colsKilogramosSacos.keyup(function() {        
        var valuesIncrement = [];
        var valuesDecrement = [];
               
        $colsKilogramosSacos.each(function(index, col) {
            
            if($(col).data('increment')) {
                valuesIncrement.push(Number($(col).val())); 
            } else {
                valuesDecrement.push(Number($(col).val()));
            }           
        });
        
        $("input[data-column='kilogramos_sacos_totales'")
                .val(obtainTotal(valuesIncrement) - obtainTotal(valuesDecrement));
        
        return;
    });
    
});

function obtainTotal(arrValues) {
    return arrValues.reduce(function(total, elem) {
        return total + elem;
    });
}

//</editor-fold>