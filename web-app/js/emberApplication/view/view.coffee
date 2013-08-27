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
  classNameBindings : ['isDisabled']

  isDisabled: (->
    "disabled" unless @.get('context.alumnos.length')
  ).property("context.alumnos.length")

  template : Ember.Handlebars.compile('Autorizar')

  click : (event) ->
    event.stopPropagation()
    @.get('controller').autorizar( @.get('context') )


App.ParticipantesView = Ember.View.extend
  elementId: 'participantes'
  tagName : 'ul'
  template: Ember.Handlebars.compile('' +
    '{{#each participante in controllers.cursosNuevos.currentCurso.alumnos }}' +
      '<li> {{ view App.ParticipanteView }} </li>' +
    '{{/each}}')

App.ParticipanteView = Ember.View.extend
  template: Ember.Handlebars.compile('' +
    '{{ participante.nombreCompleto }}{{#if participante.observaciones}} - <small>{{ participante.observaciones }}</small>{{/if}}' )

App.TextField = Ember.TextField.extend(Ember.TargetActionSupport,
  insertNewline : ->
    this.triggerAction()
)

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

  '{{view App.ConfirmDialogView ' +
      'elementId="confirmarAutorizacionDialog" ' +
      'okAction="doRealizarAutorizacion" ' +
      'cancelAction="doCancelAutorizacion" ' +
      'target="controller" ' +
      'header="¿Autorizar curso?" ' +
      'message="¿Está seguro de autorizar el curso? ¡Esta acción no se puede deshacer!"' +
  '}}' )

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

Ember.TEMPLATES['crear'] = Ember.Handlebars.compile('' +
  '<div class="container-fluid">' +
    '<div class="row-fluid">' +
      '<div class="span4">' +
        '<div class="page-header">' +
          '<h1>Programar nuevo curso</h1>' +
        '</div>' +
        '<div>' +
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
                                   'optionLabelPath="content.puerto"' +
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
                                   'optionLabelPath="content.nombre"' +
                                   'selectionBinding="cursoSelected" }}' +
            '</div>' +
          '</div>' +
        '</div>' +
        '<div class="form-actions">' +
          # '{{#linkTo "crear.participantes" class="btn btn-info" }} Crear y agregar participantes {{/linkTo}}' +
          '<button {{ action "crear" }} class="btn btn-primary" > Crear y agregar participantes </button>' +
          '<button {{ action "finalizar" }} class="btn btn-success" > Finalizar </button>' +
          # '{{#linkTo "cursosNuevos.index" class="btn btn-success" }} Finalizar {{/linkTo}}' +
        '</div>' +
      '</div>' +
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
          '{{ view App.TextField target="controller" action="agregar" valueBinding="controller.nombreCompleto" placeholder="Nombre completo" }}' +
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
    '{{ view App.ParticipantesView }}'
  '</div>'
  )

Ember.TEMPLATES['archivo'] = Ember.Handlebars.compile('' +
  '<div class="container-fluid">' +

    '<div class="row-fluid">' +
      '<div class="span12">' +
        '<div class="page-header">' +
          '<h1>Procesar archivo</h1>' +
        '</div>' +

        '<div class="row-fluid">' +
          '<div class="span6">' +
            '{{ view App.DropzoneView }}' +
            '<button class="btn btn-large btn-block btn-primary" {{ action "procesarArchivo" }} > Procesar </button>' +
          '</div>' +

          '<div class="span6">' +
            '<ul>' +
              '{{#each participante in participantes }}' +
                '<li> {{ view App.ParticipanteView }} </li>' +
              '{{/each}}' +
            '</ul>' +
          '</div>' +
        '</div>' +

      '</div>' +
    '</div>' +
  '</div>')