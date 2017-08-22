//=require datepicker/bootstrap-datepicker.js
//=require datepicker/locales/bootstrap-datepicker.es.js
//=require searchCurso/edit-curso-programado.js


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

$(function() {
  editCursoProgramado.initModule();
});
