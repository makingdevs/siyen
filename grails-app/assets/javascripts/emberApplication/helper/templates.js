$(function() {
  var template, templates, _i, _len;

  Handlebars.getTemplate = function(name) {
    if (!Ember.TEMPLATES || !Ember.TEMPLATES[name]) {
      $.ajax({
        url: "assets/emberApplication/templates/" + name + ".handlebars",
        success: function(data) {
          var nombreDelTemplate;
          nombreDelTemplate = name;
          if (name.indexOf('.') > -1) {
            nombreDelTemplate = name.replace('.', '/');
          }

          return Ember.TEMPLATES[nombreDelTemplate] = Ember.Handlebars.compile(data);
        },
        async: false
      });
    }
    return Ember.TEMPLATES[name];
  };

  templates = ['cursosNuevos', 'cursosAutorizados', 'edit', 'confirmDialog', 'crear.participantes', 'archivo', 'notificacion', 'busqueda', 'alumnos', 'busquedaAlumnos','badGateway','gatewayTimeout','alumno'];

  for (_i = 0, _len = templates.length; _i < _len; _i++) {
    template = templates[_i];
    Handlebars.getTemplate(template);
  }

  Ember.TEMPLATES['movimientos'] = Ember.Handlebars.compile("<div class=\"container-fluid\">\n  <div class=\"row-fluid\">\n    <div class=\"span6\">\n      <div class=\"control-group\">\n        <label class=\"control-label\" for=\"cursos\">Curso :</label>\n        <div class=\"controls\">\n          {{ view Ember.Select prompt=\"Selecciona un curso : \"\n                               contentBinding=\"model\"\n                               optionValuePath=\"content.id\"\n                               optionLabelPath=\"content.descripcion\"\n                               selectionBinding=\"cursoSelectedA\" }}\n        </div>\n      </div>\n      {{#if cursoSelectedA}}\n        {{ view App.ListaAlumnosView contentBinding=cursoSelectedA }}\n      {{/if}}\n    </div>\n\n    <div class=\"span6\">\n      <div class=\"control-group\">\n        <label class=\"control-label\" for=\"cursos\">Curso :</label>\n        <div class=\"controls\">\n          {{ view Ember.Select prompt=\"Selecciona un curso : \"\n                               contentBinding=\"model\"\n                               optionValuePath=\"content.id\"\n                               optionLabelPath=\"content.descripcion\"\n                               selectionBinding=\"cursoSelectedB\" }}\n        </div>\n      </div>\n      {{#if this.cursoSelectedB}}\n        {{ view App.ListaAlumnosView contentBinding=cursoSelectedB }}\n      {{/if}}\n    </div>\n  </div>\n</div>\n\n{{ view App.ConfirmDialogView\n     elementId=\"confirmarMovimientoDialog\"\n     okAction=\"doRealizarMovimiento\"\n     cancelAction=\"doCancelMovimiento\"\n     target=\"controller\"\n     header=\"Confirmación de movimiento\"\n     message=\"¿Está seguro de autorizar el movimiento?\"\n}}");

  Ember.TEMPLATES['crear'] = Ember.Handlebars.compile('' + '<div class="container-fluid">' + '<div class="row-fluid">' + '{{ view App.CursoNuevoFormulario ' + 'crearAgregarAction="crear" ' + 'target="controller" ' + 'header="Programar nuevo curso" ' + '}}' + '{{ outlet }}' + '</div>' + '</div>');

  Ember.TEMPLATES['cursoNuevoForm'] = Ember.Handlebars.compile('' + '<div class="span4">' + '<div class="page-header">' + '<h1> {{ view.header }} </h1>' + '</div>' + '<div class="control-group">' + '<label class="control-label" for="datepicker">Fecha de inicio :</label>' + '<div class="controls">' + '{{ view App.DatePickerView fechaValueBinding="fechaDeInicio" }}' + '</div>' + '</div>' + '<div class="control-group">' + '<label class="control-label" for="puerto">Puerto :</label>' + '<div class="controls">' + '{{ view Ember.Select prompt="Selecciona un puerto : "' + 'contentBinding="puertos"' + 'optionValuePath="content.clave"' + 'optionLabelPath="content.descripcion"' + 'selectionBinding="puertoSelected" }}' + '</div>' + '</div>' + '<div class="control-group">' + '<label class="control-label" for="instructores">Instructor :</label>' + '<div class="controls">' + '{{ view Ember.Select prompt="Selecciona un instructor : "' + 'contentBinding="instructores"' + 'optionValuePath="content.numeroDeOficio"' + 'optionLabelPath="content.nombre"' + 'selectionBinding="instructorSelected" }}' + '</div>' + '</div>' + '<div class="control-group">' + '<label class="control-label" for="cursos">Curso :</label>' + '<div class="controls">' + '{{ view Ember.Select prompt="Selecciona un curso : "' + 'contentBinding="cursos"' + 'optionValuePath="content.clave"' + 'optionLabelPath="content.clave"' + 'selectionBinding="cursoSelected" }}' + '</div>' + '</div>' + '<div class="form-actions">' + '{{ view App.BootstrapButton ' + 'contentBinding="view.finalizarButtonLabel" ' + 'actionBinding="view.finalizarAction" ' + 'targetBinding="view.target" ' + 'classNames="btn-success"' + '}}' + '{{#if view.crearAgregarAction}}' + '{{ view App.BootstrapButton ' + 'contentBinding="view.crearAgregarButtonLabel" ' + 'actionBinding="view.crearAgregarAction" ' + 'targetBinding="view.target" ' + 'classNames="btn-primary btn"' + '}}' + '{{/if}}' + '</div>' + '</div>');

  Ember.TEMPLATES['oficios'] = Ember.Handlebars.compile("<div class=\"page-header\">\n  <h1>Generación de oficios</h1>\n</div>\n<div class=\"form-horizontal\">\n  <div class=\"control-group\">\n    <label class=\"control-label\" for=\"dirigidoA\">Dirigido a :</label>\n    <div class=\"controls\">\n      {{ input id=\"dirigidoA\" name=\"dirigidoA\" class=\"input-xxlarge\" value=dirigidoA }}\n    </div>\n  </div>\n\n  <div class=\"control-group\">\n    <label class=\"control-label\" for=\"puesto\">Puesto :</label>\n    <div class=\"controls\">\n      {{ input id=\"puesto\" name=\"puesto\" class=\"input-xxlarge\" value=puesto }}\n    </div>\n  </div>\n\n  <div class=\"control-group\">\n    <label class=\"control-label\" for=\"puertoDeEnvio\">Puerto de envio :</label>\n    <div class=\"controls\">\n      {{ view Ember.Select prompt=\"Selecciona un puerto : \"\n                           contentBinding=\"puertos\"\n                           optionValuePath=\"content.id\"\n                           optionLabelPath=\"content.descripcion\"\n                           selectionBinding=\"puerto\" }}\n    </div>\n  </div>\n\n  <div class=\"control-group\">\n    <label class=\"control-label\" for=\"deParteDe\">De parte de :</label>\n    <div class=\"controls\">\n      {{ view Ember.Select prompt=\"Selecciona un instructor : \"\n                           id=\"deParteDe\"\n                           contentBinding=\"instructores\"\n                           optionValuePath=\"content.id\"\n                           optionLabelPath=\"content.nombre\"\n                           selectionBinding=\"deParteDe\" }}\n    </div>\n  </div>\n\n  <div class=\"control-group\">\n    <label class=\"control-label\" for=\"desde\">Desde :</label>\n    <div class=\"controls\">\n      {{ view App.DatePickerView fechaValueBinding=\"desde\" initValue=false }}\n    </div>\n  </div>\n\n  <div class=\"control-group\">\n    <label class=\"control-label\" for=\"hasta\">Hasta :</label>\n    <div class=\"controls\">\n      {{ view App.DatePickerView fechaValueBinding=\"hasta\" initValue=false }}\n    </div>\n  </div>\n\n  <div class=\"form-actions\">\n    {{ view App.OficioButton }}\n  </div>\n</div>");

});
