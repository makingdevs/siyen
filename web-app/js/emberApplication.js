// Generated by CoffeeScript 1.6.3
(function() {
  window.App = Ember.Application.create();

  $(function() {
    return ($("body")).on("click", "#impresion", function() {
      var id, urlBaseFrente, urlBaseReverso, urlFrente, urlReverso;
      id = ($(this)).attr('name');
      urlBaseFrente = ($('#frenteParaCurso')).val();
      urlFrente = "" + urlBaseFrente + "/" + id;
      urlBaseReverso = ($('#reversoParaCurso')).val();
      urlReverso = "" + urlBaseReverso + "/" + id;
      window.open(urlFrente);
      return window.open(urlReverso);
    });
  });

}).call(this);
