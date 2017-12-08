describe("Registro de Mermas", function() {
   beforeEach(function() {
      loadFixtures('mermas/mermas.html'); 
   }); 
   
   it("debe estar presente los elementos que agrupan a las mermas", function() {
       expect($("div[data-use='mermas-wrapper']")[0]).toBeInDOM();
       expect($("div[data-use='mermas-wrapper'] a.btn-mermas")[0]).toBeInDOM();
       expect($("div[data-use='mermas-wrapper'] a.btn-mermas")[0]).toBeInDOM();
       expect($("div[data-use='mermas-wrapper'] ul.nav-tabs li").length).toEqual(2);
       expect($("div[data-use='mermas-wrapper'] div.tab-pane").length).toEqual(2);
   });
   
   it("deben estar presentes los inputs del formulario", function() {
       expect($("div[data-use='mermas-wrapper'] select#merma_merma_type")[0]).toBeInDOM();
       expect($("div[data-use='mermas-wrapper'] input#merma_date_dry")[0]).toBeInDOM();
       expect($("div[data-use='mermas-wrapper'] input#merma_quantity")[0]).toBeInDOM();
       expect($("div[data-use='mermas-wrapper'] textarea#merma_observations")[0]).toBeInDOM();
   });
   
   it("el campo de cantidad debe tener la mascara para aceptar solo números", function() {
      expect($("div[data-use='mermas-wrapper'] input.merma-quantity")).toHaveMethod('mask'); 
   });
   
   it("para las mermas diferentes a secado se desabilita el input de fecha de secado", function() {
       var secado = 'Secado';
       var $typeMerma = $("div[data-use='mermas-wrapper'] select.merma_type");
       var $dryDateDiv = $typeMerma.parent().parent().next();
       
       expect($typeMerma.find('option:selected').text()).toEqual("Secado");       
       expect($dryDateDiv).not.toBeHidden();
       
   });
});