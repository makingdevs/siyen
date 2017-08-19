//=require momentjs/moment.js
//=require momentjs/lang/es.js
//=require datepicker/bootstrap-datepicker.js
//=require datepicker/locales/bootstrap-datepicker.es.js
//=require dropzone/dropzone.js
//=require vertx/sockjs.min.js
//=require vertx/vertxbus.min.js

(function() {
  window.App = Ember.Application.create();

  $(function() {
    $(document).ajaxStart(function() {
      return ($('.overlay')).show();
    });
    $(document).ajaxStop(function() {
      return ($('.overlay')).hide();
    });
    ($("body")).on("click", "#impresion", function() {
      var id, urlBaseFrente, urlBaseReverso, urlFrente, urlReverso;
      id = ($(this)).attr('name');
      urlBaseFrente = ($('#frenteParaCurso')).val();
      urlFrente = "" + urlBaseFrente + "/" + id;
      urlBaseReverso = ($('#reversoParaCurso')).val();
      urlReverso = "" + urlBaseReverso + "/" + id;
      window.open(urlFrente);
      return window.open(urlReverso);
    });
    return ($("body")).on("click", "#impresionDeAlumno", function() {
      var id, urlBaseFrente, urlBaseReverso, urlFrente, urlReverso;
      id = ($(this)).attr('name');
      urlBaseFrente = ($('#frenteParaCursoPorAlumno')).val();
      urlFrente = "" + urlBaseFrente + "/" + id;
      urlBaseReverso = ($('#reversoParaCursoPorAlumno')).val();
      urlReverso = "" + urlBaseReverso + "/" + id;
      window.open(urlFrente);
      window.open(urlReverso);
      return false;
    });
  });

}).call(this);
