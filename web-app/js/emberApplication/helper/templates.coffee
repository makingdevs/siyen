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

templates = [ 'cursosNuevos', 'cursosAutorizados', 'edit', 'confirmDialog', 'crear.participantes', 'archivo', 'notificacion', 'busqueda', 'alumnos', 'busquedaAlumnos' ]
for template in templates
  Handlebars.getTemplate( template )

Ember.TEMPLATES['alumno'] = Ember.Handlebars.compile("""
  <div class="page-header">
    <h1> Datos del alumno </h1>
  </div>
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span6">
        <dl class="dl-horizontal">
          <dt>Número de control</dt>
          <dd>{{ numeroDeControl }}</dd>

          <dt>Nombre completo</dt>
          <dd>{{ nombreCompleto }}</dd>

          <dt>Observaciones</dt>
          <dd>{{ observaciones }}</dd>

          <dt>Monto</dt>
          <dd>{{ monto }}</dd>
        </dl>
      </div>

      <div class="span6">
        <dl class="dl-horizontal">
          <dt>Número de curso</dt>
          <dd>{{ cursoProgramado.id }}</dd>

          <dt>Fecha de inicio</dt>
          <dd>{{ date cursoProgramado.fechaDeInicio }}</dd>

          <dt>Puerto</dt>
          <dd>{{ cursoProgramado.puerto.descripcion }}</dd>

          <dt>Instructor</dt>
          <dd>{{ cursoProgramado.instructor.nombre }}</dd>

          <dt>Curso</dt>
          <dd>
            {{ view Ember.Select prompt="Selecciona un curso : "
                                 contentBinding="cursos"
                                 optionValuePath="content.clave"
                                 optionLabelPath="content.clave"
                                 selectionBinding="model.cursoProgramado.curso" }}
          </dd>
        </dl>

        <button class="btn btn-danger btn-large btn-block" {{ action realizarMovimiento }}><i class="icon-warning-sign icon-white"></i> Crear nuevo curso para alumno certificado con el mismo puerto, instructor y fecha, con cambio de categoría</button>
      </div>
    </div>
  </div>

  {{ view App.ConfirmDialogView
       elementId="movimientoConfirmDialog"
       okAction="doConfirmarMovimiento"
       cancelAction="doCancelarMovimiento"
       target="controller"
       header="¿Autorizar movimiento?"
       message="¿Está seguro de crear el nuevo curso con un solo alumno? ¡Esta acción no se puede deshacer!"
  }}

  {{ view App.ConfirmDialogView
       elementId="duplicacion"
       target="controller"
       header="Datos duplicados"
  }}

  """)

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
        {{#if cursoSelectedA}}
          {{ view App.ListaAlumnosView contentBinding=cursoSelectedA }}
        {{/if}}
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
        {{#if this.cursoSelectedB}}
          {{ view App.ListaAlumnosView contentBinding=cursoSelectedB }}
        {{/if}}
      </div>
    </div>
  </div>

  {{ view App.ConfirmDialogView
       elementId="confirmarMovimientoDialog"
       okAction="doRealizarMovimiento"
       cancelAction="doCancelMovimiento"
       target="controller"
       header="Confirmación de movimiento"
       message="¿Está seguro de autorizar el movimiento?"
  }}
  """)

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

Ember.TEMPLATES['oficios'] = Ember.Handlebars.compile("""
  <div class="page-header">
    <h1>Generación de oficios</h1>
  </div>
  <div class="form-horizontal">
    <div class="control-group">
      <label class="control-label" for="dirigidoA">Dirigido a :</label>
      <div class="controls">
        {{ input id="dirigidoA" name="dirigidoA" class="input-xxlarge" value=dirigidoA }}
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="puesto">Puesto :</label>
      <div class="controls">
        {{ input id="puesto" name="puesto" class="input-xxlarge" value=puesto }}
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="puertoDeEnvio">Puerto de envio :</label>
      <div class="controls">
        {{ view Ember.Select prompt="Selecciona un puerto : "
                             contentBinding="puertos"
                             optionValuePath="content.id"
                             optionLabelPath="content.descripcion"
                             selectionBinding="puerto" }}
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="deParteDe">De parte de :</label>
      <div class="controls">
        {{ view Ember.Select prompt="Selecciona un instructor : "
                             id="deParteDe"
                             contentBinding="instructores"
                             optionValuePath="content.id"
                             optionLabelPath="content.nombre"
                             selectionBinding="deParteDe" }}
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="desde">Desde :</label>
      <div class="controls">
        {{ view App.DatePickerView fechaValueBinding="desde" initValue=false }}
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="hasta">Hasta :</label>
      <div class="controls">
        {{ view App.DatePickerView fechaValueBinding="hasta" initValue=false }}
      </div>
    </div>

    <div class="form-actions">
      {{ view App.OficioButton }}
    </div>
  </div>
  """)
