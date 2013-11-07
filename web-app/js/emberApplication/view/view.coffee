App.CursosNuevosView = Ember.View.extend
  elementId : "cursosNuevos"

App.DatePickerView = Ember.View.extend
  template: Ember.Handlebars.compile(
    '<div class="input-append date" id="datepicker" >' +
      '{{ view Ember.TextField valueBinding="fechaDeInicio" }}' +
      '<span class="add-on"><i class="icon-th"></i></span>' +
    '</div>'
    )

  didInsertElement: ->
    ($ '#datepicker').datepicker
      format          : "dd/MM/yyyy"
      autoclose       : true
      todayHighlight  : true
      language        : 'es'
      startDate       : '1d'
      
    ($ "#datepicker > input").attr('readonly', 'true')
    ($ "#datepicker > input").val(moment().format('DD/MMMM/YYYY'))

App.DropzoneView = Ember.View.extend
  template : Ember.Handlebars.compile('<div id="dropzone" class="dropzone"> </div>')

  didInsertElement: ->
    $('div#dropzone').dropzone(
      url : "procesarArchivo"
      addRemoveLinks : true
      maxFiles : 1
      maxFilesize: 3
      autoProcessQueue : false
    )

App.CursoNuevoListView = Ember.View.extend
  elementId: 'cursoNuevoList'
  tagName : ''
  template: Ember.Handlebars.compile('' +
    '{{#each controller}}' +
      '{{ view App.CursoNuevoItemView contentBinding="this" }}' +
    '{{/each}}')

App.CursoNuevoItemView = Ember.View.extend
  tagName : 'tr'
  template : Ember.Handlebars.compile('' +
      '<td> {{ date fechaDeInicio }} </td>' +
      '<td> {{ puerto.clave }} - {{ puerto.puerto }} </td>' +
      '<td> {{ curso.clave }} </td>' +
      '<td> {{ instructor.nombre }} </td>' +
      '<td> {{ alumnos.length }}' +
      '<td> {{ view App.AutorizarView }} </td>'
  )

  click: -> 
    @.get('controller').set('currentCurso', @.get('content'))

App.AutorizarView = Ember.View.extend
  tagName : 'button'
  classNames : ['btn', 'btn-warning']
  attributeBindings : ['disabled']

  disabled: (->
    "disabled" unless @.get('context.alumnos.length')
  ).property("context.alumnos.length")

  template : Ember.Handlebars.compile('Autorizar')

  click : (event) ->
    event.stopPropagation()
    @.get('controller').set( 'autorizarCurso', @.get('context') )
    @.get('controller').autorizar()

App.ParticipantesListView = Ember.View.extend
  elementId: 'participantes'
  tagName : 'ul'
  template: Ember.Handlebars.compile('' +
    '{{#each controllers.cursosNuevos.currentCurso.alumnos}}' +
      '{{ view App.ParticipanteView contentBinding="this" }}' +
    '{{/each}}')

App.ParticipanteView = Ember.View.extend
  tagName : 'li'
  template: Ember.Handlebars.compile('' +
    '{{ nombreCompleto }}{{#if observaciones}} - <small>{{ observaciones }}</small>{{/if}}' )

  click : (event) ->
    controller = @get('controller')
    controller.set('nombreCompleto', @get('context.nombreCompleto'))
    controller.set('observaciones', @get('context.observaciones'))
    controller.set('currentParticipanteIndex', @get('_parentView.contentIndex'))
    ($ '#nombreCompleto').focus()

App.TextField = Ember.TextField.extend(Ember.TargetActionSupport,
  insertNewline : ->
    @triggerAction()
)

App.BootstrapButton = Ember.View.extend(Ember.TargetActionSupport,
  tagName: 'button',
  classNames: ['btn']
  iconName : null
  disabled: false,
  click: ->
    if !@.get('disabled')
      @.triggerAction()

  template: Ember.Handlebars.compile('{{#if view.iconName}}<i {{bindAttr class="view.iconName"}}></i>{{/if}} {{view.content}}')
)

App.CertificadoButton = Ember.View.extend(Ember.TargetActionSupport,
  tagName: 'a',
  classNames: ['btn btn-success']
  iconName : "icon-print icon-white"
  click: ->
    debugger
    id = @get('context.id')

    urlBaseFrente = ($ '#frenteParaCurso').val()
    urlFrente = "#{urlBaseFrente}/#{id}"

    urlBaseReverso = ($ '#reversoParaCurso').val()
    urlReverso = "#{urlBaseReverso}/#{id}"

    window.open(urlFrente)
    window.open(urlReverso)

  template: Ember.Handlebars.compile('<i {{bindAttr class="view.iconName"}}></i>')
)

App.CursosAutorizadosView = Ember.View.extend()

App.ConfirmDialogView = Ember.View.extend
  templateName: 'confirmDialog'
  classNames: ['modal', 'hide']
  cancelButtonLabel: 'Cancel'
  cancelAction: null
  okButtonLabel: "Confirmar"
  okAction: null
  header: null
  message: null
  target: null

App.CursoNuevoFormulario = Ember.View.extend
  templateName: 'cursoNuevoForm'
  finalizarButtonLabel: "Finalizar"
  finalizarAction: "finalizar"
  crearAgregarButtonLabel: "Crear y agregar participantes"
  crearAgregarAction: null
  header: null
  target: null

Ember.TEMPLATES['cursosAutorizados'] = Ember.Handlebars.compile('' +
  '<div class="page-header">' +
    '<h1>Cursos programados</h1>' +
  '</div>' +
  '<table class="table table-condensed table-striped table-hover">' +
    '<thead>' +
      '<tr>' +
        '<th>Fecha de inicio</th>' +
        '<th>Fecha de termino</th>' +
        '<th>Puerto</th>' +
        '<th>Curso</th>' +
        '<th>Instructor</th>' +
        '<th>Participantes</th>' +
        '<th>Certificados</th>' +
        '<th>&nbsp;</th>' +
      '</tr>' +
    '</thead>' +
    '<tbody>' +
      '{{#each controller}}' +
        '<tr>' +
          '<td> {{ date fechaDeInicio }} </td>' +
          '<td> {{ date fechaDeTermino }} </td>' +
          '<td> {{ puerto.clave }} - {{ puerto.puerto }} </td>' +
          '<td> {{ curso.clave }} </td>' +
          '<td> {{ instructor.nombre }} </td>' +
          '<td> {{ alumnos.length }} </td>' +
          '<td> {{ view App.CertificadoButton }} </td>' +
          '<td> {{#link-to "edit" this }} Editar {{/link-to}} </td>' +
        '</tr>' +
      '{{/each}}' +
    '</tbody>' +
  '</table>' +
  '{{ outlet }}' )

Ember.TEMPLATES['edit'] = Ember.Handlebars.compile('' +
  '<div class="container-fluid">' +
    '<div class="row-fluid">' +
      '<div class="span4">' +
        '<div class="page-header">' +
          '<h1> Actualizar curso </h1>' +
        '</div>' +
        '<div class="control-group">' +
          '<label class="control-label" for="datepicker">Fecha de inicio :</label>' +
          '<div class="controls">' +
            '{{ view Ember.TextField valueBinding="fechaDeInicio" disabled="disabled"}}' +
          '</div>' +
        '</div>' +

        '<div class="control-group">' +
          '<label class="control-label" for="puerto">Puerto :</label>' +
          '<div class="controls">' +
            '{{ view Ember.TextField valueBinding="model.puerto.descripcion" disabled="disabled" }}' +
          '</div>' +
        '</div>' +
        '<div class="control-group">' +
          '<label class="control-label" for="instructores">Instructor :</label>' +
          '<div class="controls">' +
            '{{ view Ember.TextField valueBinding="model.instructor.nombre" disabled="disabled" }}' +
          '</div>' +
        '</div>' +
        '<div class="control-group">' +
          '<label class="control-label" for="cursos">Curso :</label>' +
          '<div class="controls">' +
            '{{ view Ember.Select prompt="Selecciona un curso : "' +
                                 'contentBinding="cursos"' +
                                 'optionValuePath="content.clave"' +
                                 'optionLabelPath="content.clave"' +
                                 'selectionBinding="model.curso" }}' +
          '</div>' +
        '</div>' +
        '<div class="form-actions">' +
          '{{ view App.BootstrapButton ' +
                  'content="Actualizar datos del curso" ' +
                  'action="actualizarCurso" ' +
                  'target="controller" ' +
                  'classNames="btn-success"' +
          '}}' +
        '</div>' +
      '</div>' +
      '<div class="span4">' +
        '<div class="page-header">' +
          '<h1>Participante</h1>' +
        '</div>' +
        '<div>' +
          '<div class="control-group">' +
            '<label class="control-label" for="nombreCompleto">Nombre Completo :</label>' +
            '<div class="controls">' +
              '{{ view App.TextField id="nombreCompleto" target="controller" action="actualizar" valueBinding="controller.nombreCompleto" placeholder="Nombre completo" }}' +
            '</div>' +
          '</div>' +

          '<div class="control-group">' +
            '<label class="control-label" for="observaciones">Observaciones :</label>' +
            '<div class="controls">' +
              '{{ view Ember.TextArea valueBinding="observaciones" placeholder="Observaciones" }}' +
            '</div>' +
          '</div>' +

          '<div class="form-actions">' +
            '<button class="btn btn-primary" {{ action "actualizar" }}> Actualizar lista </button>' +
          '</div>' +
        '</div>' +
      '</div>' +
      '<div class="span4" >' +
        '<div class="page-header">' +
          '<h1>Lista de participantes</h1>' +
        '</div>' +
        '{{ view App.EditarParticipantesListView }}' +
      '</div>' +
    '</div>' +
  '</div>' )

App.EditarParticipantesListView = Ember.View.extend
  elementId: 'participantes'
  tagName : 'ul'
  template: Ember.Handlebars.compile('' +
    '{{#each model.alumnos}}' +
      '{{ view App.ParticipanteView contentBinding="this" }}' +
    '{{/each}}')

Ember.TEMPLATES['cursosNuevos'] = Ember.Handlebars.compile('' +
  '<div class="page-header">' +
    '<h1>Nuevos cursos</h1>' +
  '</div>' +
  '<table class="table table-condensed table-striped table-hover">' +
    '<thead>' +
      '<tr>' +
        '<th>Fecha de inicio</th>' +
        '<th>Puerto</th>' +
        '<th>Curso</th>' +
        '<th>Instructor</th>' +
        '<th>Participantes</th>' +
        '<th>Autorizar</th>' +
      '</tr>' +
    '</thead>' +
    '<tbody>' +
      '{{ view App.CursoNuevoListView }}' +
    '</tbody>' +
  '</table>' +
  '{{#linkTo "crear" class="btn btn-primary" }} Nuevo {{/linkTo}}' +
  '{{ outlet }}' +

  '{{ view App.ConfirmDialogView ' +
       'elementId="confirmarAutorizacionDialog" ' +
       'okAction="doRealizarAutorizacion" ' +
       'cancelAction="doCancelAutorizacion" ' +
       'target="controller" ' +
       'header="¿Autorizar curso?" ' +
       'message="¿Está seguro de autorizar el curso? ¡Esta acción no se puede deshacer!"' +
  '}}' )

Ember.TEMPLATES['confirmDialog'] = Ember.Handlebars.compile(
  '<div class="modal-header centerAlign">' +
    '<button type="button" class="close" data-dismiss="modal" class="floatRight">×</button>' +
    '<h1 class="centerAlign">{{view.header}}</h1>' +
  '</div>' +
  '<div class="modal-body">' +
    '{{view.message}}' +
  '</div>' +
  '<div class="modal-footer">' +
    '{{#if view.cancelAction}}' +
      '{{ view App.BootstrapButton ' +
              'contentBinding="view.cancelButtonLabel" ' +
              'actionBinding="view.cancelAction"' +
              'targetBinding="view.target"'  +
      '}}' +
    '{{/if}}' +
    '{{#if view.okAction}}' +
      '{{ view App.BootstrapButton ' +
              'contentBinding="view.okButtonLabel" ' +
              'actionBinding="view.okAction" ' +
              'targetBinding="view.target" ' +
              'iconName="icon-exclamation-sign icon-white" ' +
              'classNames="btn-warning"' +
      '}}' +
    '{{/if}}' +
  '</div>'
)

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

Ember.TEMPLATES['crear/participantes'] = Ember.Handlebars.compile('' +
  '<div class="span4">' +
    '<div class="page-header">' +
      '<h1>Participante</h1>' +
    '</div>' +
    '<div>' +
      '<div class="control-group">' +
        '<label class="control-label" for="nombreCompleto">Nombre Completo :</label>' +
        '<div class="controls">' +
          '{{ view App.TextField id="nombreCompleto" target="controller" action="agregar" valueBinding="controller.nombreCompleto" placeholder="Nombre completo" }}' +
        '</div>' +
      '</div>' +

      '<div class="control-group">' +
        '<label class="control-label" for="observaciones">Observaciones :</label>' +
        '<div class="controls">' +
          '{{ view Ember.TextArea valueBinding="observaciones" placeholder="Observaciones" }}' +
        '</div>' +
      '</div>' +

      '<div class="form-actions">' +
        '{{#linkTo "crear.index" class="btn" }} Ocultar {{/linkTo}}' +
        '<button class="btn btn-primary" {{ action "agregar" }}> Agregar </button>' +
      '</div>' +
    '</div>' +
  '</div>' +
  '<div class="span4" >' +
    '<div class="page-header">' +
      '<h1>Lista de participantes</h1>' +
    '</div>' +
    '{{ view App.ParticipantesListView }}' +
  '</div>'
  )

Ember.TEMPLATES['archivo'] = Ember.Handlebars.compile('' +
  '<div class="container-fluid">' +
    '<div class="row-fluid">' +

      '<div class="span4">' +
        '<div class="page-header">' +
          '<h1>Procesar archivo</h1>' +
        '</div>' +

        '{{ view App.DropzoneView }}' +
        '<button class="btn btn-large btn-block btn-primary" {{ action "procesarArchivo" }} > Procesar </button>' +
      '</div>' +

      '<div class="span4">' +
        '<ul>' +
          '{{#each participantes }}' +
            '{{ view App.ParticipanteView }}' +
          '{{/each}}' +
        '</ul>' +
      '</div>' +

      '{{#if participantes}}' +
        '{{ view App.CursoNuevoFormulario ' +
            'target="controller" ' +
            'header="Datos del curso" ' +
        '}}' +
      '{{/if}}' +
    '</div>' +
  '</div>' )

Ember.TEMPLATES['cursoNuevoForm'] = Ember.Handlebars.compile(
  '<div class="span4">' +
    '<div class="page-header">' +
      '<h1> {{ view.header }} </h1>' +
    '</div>' +
    '<div class="control-group">' +
      '<label class="control-label" for="datepicker">Fecha de inicio :</label>' +
      '<div class="controls">' +
        '{{ view App.DatePickerView }}' +
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


App.NotifacionView = Ember.View.extend()
Ember.TEMPLATES['notificacion'] = Ember.Handlebars.compile('' +
  '<div class="page-header">' +
    '<h1>Cursos creados</h1>' +
  '</div>' +
  '<table class="table table-condensed table-striped table-hover">' +
    '<thead>' +
      '<tr>' +
        '<th>ID</th>' +
        '<th>Fecha de autorización</th>' +
        '<th>Fecha de inicio</th>' +
        '<th>Puerto</th>' +
        '<th>Curso</th>' +
        '<th>Instructor</th>' +
        '<th>Participantes</th>' +
        '<th>Acción realizada</th>' +
        '<th>Creado por</th>' +
      '</tr>' +
    '</thead>' +
    '<tbody>' +
      '{{#each controller}}' +
        '<tr>' +
          '<td> {{ id }} </td>' +
          '<td> {{ fechaDeAutorizacion }} </td>' +
          '<td> {{ fechaDeInicio }} </td>' +
          '<td> {{ puerto }} </td>' +
          '<td> {{ curso }} </td>' +
          '<td> {{ instructor }} </td>' +
          '<td> {{ alumnos }} </td>' +
          '<td> {{ accion }} </td>' +
          '<td> {{ creadoPor }} </td>' +
        '</tr>' +
      '{{/each}}' +
    '</tbody>' +
  '</table>' )

App.BusquedaChosenView = Ember.View.extend
  tagName: 'select'
  attributeBindings: ['multiple']
  multiple: 'multiple'

  didInsertElement: ->
    $("#busquedaChosen").chosen
      disable_search: true
      search_contains : true
      display_selected_options : false
      placeholder_text_multiple : "Selecciona algunas opciones"
      no_results_text: "Oops, ¡No hubo resultados!"

App.BusquedaView = Ember.View.extend()
Ember.TEMPLATES['busqueda'] = Ember.Handlebars.compile('' +
  '<div class="input-append">' +
    '{{ view App.BusquedaChosenView id="busquedaChosen" class="input-xxlarge" action="realizarBusqueda" valueBinding="busqueda" }}' +
    '<button type="submit" class="btn" {{ action "realizarBusqueda" }} >Buscar</button>' +
  '</div>' +
  '<div id="resultados"> </div>'
  )