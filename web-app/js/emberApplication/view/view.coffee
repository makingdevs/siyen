App.CursosNuevosView = Ember.View.extend
  elementId : "cursosNuevos"

App.DatePickerView = Ember.View.extend
  fechaValue : null
  initValue : true
  template: Ember.Handlebars.compile(
    '<div class="input-append date" >' +
      '{{ view Ember.TextField valueBinding="view.fechaValue" class="datepicker" }}' +
      '<span class="add-on"><i class="icon-th"></i></span>' +
    '</div>'
    )

  didInsertElement: ->
    ($ '.datepicker').datepicker
      format          : "dd/MM/yyyy"
      autoclose       : true
      todayHighlight  : true
      language        : 'es'
      startDate       : '1d' if @get('initValue') == true
      clearBtn        : !@get('initValue')

    ($ ".datepicker").attr('readonly', 'true')
    ($ ".datepicker").val(moment().format('DD/MMMM/YYYY')) if @get('initValue')

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

App.EditarParticipantesListView = Ember.View.extend
  elementId: 'participantes'
  tagName : 'ul'
  template: Ember.Handlebars.compile('' +
    '{{#each model.alumnos}}' +
      '{{ view App.ParticipanteView contentBinding="this" }}' +
    '{{/each}}')

App.NotifacionView = Ember.View.extend()

App.BusquedaView = Ember.View.extend
  didInsertElement : ->
    tamanioCampoBusqueda = $("input[name='busqueda']").width()
    $("#busquedaAvanzada").width tamanioCampoBusqueda
    $("#mostrarBusquedaAvanzada").click ->
      $("#busquedaAvanzada").toggle "slow"
      $(".busquedaChosen").chosen
        disable_search: true
        search_contains : true
        display_selected_options : false
        placeholder_text_multiple : "Selecciona algunas opciones"
        no_results_text: "Oops, ¡No hubo resultados!"

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

App.BusquedaAvanzadaView = Ember.View.extend
  classNames : "hide"
  template : Ember.Handlebars.compile('' +
    '<div class="control-group">' +
      '<label class="control-label" for="cursos">Cursos :</label>' +
      '<div class="controls">' +
        '<select id="cursos" class="busquedaChosen input-xxlarge" multiple> </select>' +
      '</div>' +
    '</div>' +
    '<div class="control-group">' +
      '<label class="control-label" for="puertos">Puertos :</label>' +
      '<div class="controls">' +
        '<select id="puertos" class="busquedaChosen input-xxlarge" multiple> </select>' +
      '</div>' +
    '</div>' +
    '<div class="control-group">' +
      '<label class="control-label" for="instructores">Instructores :</label>' +
      '<div class="controls">' +
        '<select id="instructores" class="busquedaChosen input-xxlarge" multiple> </select>' +
      '</div>' +
    '</div>' +
    '<div class="control-group">' +
      '<label class="control-label" for="instructores">Desde :</label>' +
      '<div class="controls">' +
        '{{ view App.DatePickerView fechaValueBinding="desde" initValue=false }}' +
      '</div>' +
    '</div>' +
    '<div class="control-group">' +
      '<label class="control-label" for="instructores">Hasta :</label>' +
      '<div class="controls">' +
        '{{ view App.DatePickerView fechaValueBinding="hasta" initValue=false }}' +
      '</div>' +
    '</div>'
  )