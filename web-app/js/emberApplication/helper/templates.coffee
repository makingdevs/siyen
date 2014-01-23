Handlebars.getTemplate = (name) ->
  if (!Ember.TEMPLATES || !Ember.TEMPLATES[name])
    $.ajax
      url : "js/emberApplication/templates/#{name}.handlebars"
      success : (data) ->
        nombreDelTemplate = name
        if name.indexOf('.') > -1
          nombreDelTemplate = name.replace('.', '/')
        Ember.TEMPLATES[nombreDelTemplate] = Ember.Handlebars.compile(data)

      async : false

  Ember.TEMPLATES[name]

templates = [ 'cursosNuevos', 'cursosAutorizados', 'edit', 'confirmDialog', 'crear.participantes', 'archivo', 'notificacion', 'busqueda' ]
for template in templates
  Handlebars.getTemplate( template )

Ember.TEMPLATES['movimientos'] = Ember.Handlebars.compile("""
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span6">
        <div class="control-group">
          <label class="control-label" for="cursos">Curso :</label>
          <div class="controls">
            {{ view Ember.Select prompt="Selecciona un curso : "
                                 contentBinding="model"
                                 optionValuePath="content.id"
                                 optionLabelPath="content.descripcion"
                                 selectionBinding="cursoSelectedA" }}
          </div>
        </div>
        {{ view App.ListaAlumnosView contentBinding=cursoSelectedA }}
      </div>

      <div class="span6">
        <div class="control-group">
          <label class="control-label" for="cursos">Curso :</label>
          <div class="controls">
            {{ view Ember.Select prompt="Selecciona un curso : "
                                 contentBinding="model"
                                 optionValuePath="content.id"
                                 optionLabelPath="content.descripcion"
                                 selectionBinding="cursoSelectedB" }}
          </div>
        </div>
        {{ view App.ListaAlumnosView contentBinding=cursoSelectedB }}
      </div>
    </div>
  </div>""")

Ember.TEMPLATES['crear'] = Ember.Handlebars.compile('' +
  '<div class="container-fluid">' +
    '<div class="row-fluid">' +
      '{{ view App.CursoNuevoFormulario ' +
              'crearAgregarAction="crear" ' +
              'target="controller" ' +
              'header="Programar nuevo curso" ' +
      '}}' +
      '{{ outlet }}' +
    '</div>' +
  '</div>')

Ember.TEMPLATES['cursoNuevoForm'] = Ember.Handlebars.compile('' +
  '<div class="span4">' +
    '<div class="page-header">' +
      '<h1> {{ view.header }} </h1>' +
    '</div>' +
    '<div class="control-group">' +
      '<label class="control-label" for="datepicker">Fecha de inicio :</label>' +
      '<div class="controls">' +
        '{{ view App.DatePickerView fechaValueBinding="fechaDeInicio" }}' +
      '</div>' +
    '</div>' +
    '<div class="control-group">' +
      '<label class="control-label" for="puerto">Puerto :</label>' +
      '<div class="controls">' +
        '{{ view Ember.Select prompt="Selecciona un puerto : "' +
                             'contentBinding="puertos"' +
                             'optionValuePath="content.clave"' +
                             'optionLabelPath="content.descripcion"' +
                             'selectionBinding="puertoSelected" }}' +
      '</div>' +
    '</div>' +
    '<div class="control-group">' +
      '<label class="control-label" for="instructores">Instructor :</label>' +
      '<div class="controls">' +
        '{{ view Ember.Select prompt="Selecciona un instructor : "' +
                             'contentBinding="instructores"' +
                             'optionValuePath="content.numeroDeOficio"' +
                             'optionLabelPath="content.nombre"' +
                             'selectionBinding="instructorSelected" }}' +
      '</div>' +
    '</div>' +
    '<div class="control-group">' +
      '<label class="control-label" for="cursos">Curso :</label>' +
      '<div class="controls">' +
        '{{ view Ember.Select prompt="Selecciona un curso : "' +
                             'contentBinding="cursos"' +
                             'optionValuePath="content.clave"' +
                             'optionLabelPath="content.clave"' +
                             'selectionBinding="cursoSelected" }}' +
      '</div>' +
    '</div>' +
    '<div class="form-actions">' +
      '{{ view App.BootstrapButton ' +
              'contentBinding="view.finalizarButtonLabel" ' +
              'actionBinding="view.finalizarAction" ' +
              'targetBinding="view.target" ' +
              'classNames="btn-success"' +
      '}}' +
      '{{#if view.crearAgregarAction}}' +
        '{{ view App.BootstrapButton ' +
                'contentBinding="view.crearAgregarButtonLabel" ' +
                'actionBinding="view.crearAgregarAction" ' +
                'targetBinding="view.target" ' +
                'classNames="btn-primary btn"' +
        '}}' +
      '{{/if}}' +
    '</div>' +
  '</div>' )
