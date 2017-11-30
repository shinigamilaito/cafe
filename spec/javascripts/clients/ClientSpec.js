describe("Registro de clientes", function() {  
  var $personaFisica;
  var $noPersonaFisica;
  var $representanteLegal;
  var $organizacion;

  beforeEach(function() {
    loadFixtures('clients/form_clientes.html');      
    $personaFisica = $("input:radio#client_persona_fisica_true");
    $noPersonaFisica = $("input:radio#client_persona_fisica_false");
    $representanteLegal = $('#client_legal_representative');
    $organizacion = $('#client_organization');
    
    clienteMock = new Cliente({
        $personaFisica: $personaFisica,
        $noPersonaFisica: $noPersonaFisica,
        $representanteLegal: $representanteLegal,
        $organizacion: $organizacion
    });
  });

  it("verificando que existan los radio button para persona fisica", function() {
     expect($personaFisica[0]).toBeInDOM(); 
     expect($("input:radio#client_persona_fisica_false")[0]).toBeInDOM(); 
  });
  
  it("verificando que existan inputs para representante legal y organizacion", function() {
     expect($representanteLegal[0]).toBeInDOM(); 
     expect($organizacion[0]).toBeInDOM(); 
  });

  it("cliente debe estar presente", function(){
      expect(cliente).toBeDefined();
      expect(cliente).not.toBeNull();
  });

  it("Se debe habilitar la organizacion si es persona fisica", function() {
      spyOn(clienteMock, 'actualizarOrganizacion').and.callThrough();
      var spyEvent = spyOnEvent($personaFisica, 'click');
      
      expect($organizacion).not.toHaveAttr('readonly');  
      
      $representanteLegal.val("XXXXX");
      $personaFisica.click();
      
      expect('click').toHaveBeenTriggeredOn($personaFisica);
      expect(spyEvent).toHaveBeenTriggered();
      expect(clienteMock.actualizarOrganizacion).toHaveBeenCalled();
      expect($organizacion).toHaveAttr('readonly', 'readonly');
      expect($organizacion).toHaveValue("XXXXX");
  });
  
  it("deberia desabilitar la organizacion cuando no es persona fisica", function() {      
      var spyEvent = spyOnEvent($noPersonaFisica, 'click');
      
      $organizacion.val("AAAAA");
      $organizacion.attr('readonly', 'readonly');
      
      expect($organizacion).toHaveAttr('readonly');  
      expect($organizacion).toHaveValue("AAAAA");
      
      $noPersonaFisica.click();
      
      expect('click').toHaveBeenTriggeredOn($noPersonaFisica);
      expect(spyEvent).toHaveBeenTriggered();
      expect($organizacion).not.toHaveAttr('readonly');
      expect($organizacion).toHaveValue("");
      
  });
  
  it("debe tener el mismo representante legal y organizacion si es persona fisica", function() {
      var spyEvent = spyOnEvent($representanteLegal, 'keyup');
      
      $noPersonaFisica.click();      
      $representanteLegal.val("AAAAA");      
      
      expect($representanteLegal).toHaveValue("AAAAA");      
      expect($noPersonaFisica).toBeChecked();
      
      $representanteLegal.keyup();
      
      expect('keyup').toHaveBeenTriggeredOn($representanteLegal);
      expect(spyEvent).toHaveBeenTriggered();
      expect($organizacion).toHaveValue("");
      
  });  
});