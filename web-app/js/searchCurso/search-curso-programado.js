var searchCursoProgramado = (function(){

  //campos del formulario
  var getStringToSearch = function(){return $('#stringToSearch').val();},
      getClaveCurso = function(){return $('#claveCurso').val();},
      getClavePuerto = function(){return $('#clavePuerto').val();},
      getNombreInstructor = function(){return $('#nombreInstructor').val();},
      getDesde = function(){return $('#desde').val();},
      getHasta = function(){return $('#hasta').val();},
      getUrl = function(){return $('#urlSearchCurso').val();},
      buttonSearch = '#busquedaButton',
      buttonAdvancedSearch = '#mostrarBusquedaAvanzada',
      boxAdvancedSearch = '#busquedaAvanzada',
      isVisibleAdvancedSearch = false,
      divUpdate = "#resultados";

  //functions
  var initModule, showAdvancedSearch, search;

  initModule = function(){
    $(buttonSearch).on( "click", search );
    $(buttonAdvancedSearch).on( "click", showAdvancedSearch );
    $('#desde').datepicker();
    $('#hasta').datepicker();
    $(document).keyup(function(e) {
      if (e.keyCode == 27 && isVisibleAdvancedSearch) {
        showAdvancedSearch();
      }
    });
  };

  showAdvancedSearch = function(){
    if(isVisibleAdvancedSearch){
      isVisibleAdvancedSearch = false;
      $(boxAdvancedSearch).addClass('hide');
    }else{
      isVisibleAdvancedSearch = true;
      $(boxAdvancedSearch).removeClass('hide');
    }
  };

  search = function(){
    var data = {
      buscar : getStringToSearch(),
      cursos : getClaveCurso(),
      puertos : getClavePuerto(),
      instructores : getNombreInstructor()
    }
    var url = getUrl();
    var parametros = jQuery.param( data );
    window.location = url+"?"+parametros;
  };

  return {
    initModule : initModule
  };
}());
searchCursoProgramado.initModule();
