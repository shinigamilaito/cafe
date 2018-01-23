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