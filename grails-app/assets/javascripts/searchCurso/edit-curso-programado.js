var editCursoProgramado = (function(){
  var fechaDeInicio = "#fechaDeInicio",
      msgBox = "#msgSuccessBox",
  //functions
      initModule, hideMessage;

  hideMessage = function(){
    $(msgBox).remove();
  };

  initModule = function(){
    $(fechaDeInicio).datepicker({format:'dd/mm/yyyy'});
    setTimeout(function() {
     hideMessage();
    }, 5000);
  };

  return{
    initModule: initModule
  };
}());

editCursoProgramado.initModule();