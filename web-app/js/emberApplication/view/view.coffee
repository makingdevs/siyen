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
      startDate       : '-15d' if @get('initValue') == true
      clearBtn        : !@get('initValue')

    ($ ".datepicker").attr('readonly', 'true')
    ($ ".datepicker").val(moment().format('DD/MMMM/YYYY')) if @get('initValue')

App.DropzoneView = Ember.View.extend
  template : Ember.Handlebars.compile('<div id="dropzone" class="dropzone"> </div>')

  didInsertElement: ->
    Dropzone.autoDiscover = false
    $('div#dropzone').dropzone(
      url : "procesarArchivo"
      addRemoveLinks : true
      maxFiles : 1
      maxFilesize: 3
      autoProcessQueue : false
    )

    dropzone = Dropzone.forElement("div#dropzone.dropzone")
    dropzone.on "success", (file, response) =>
      file.previewElement.classList.add("dz-success")
      for fila in response.contenidoDeFilas
        participantes = @get("controller.participantes")
        participantes.pushObject( Ember.Object.create
          nombreCompleto : fila.get(0)
          observaciones : $.trim(fila.get(1))
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

App.EditarParticipantesListView = Ember.View.extend
  elementId: 'participantes'
  tagName : 'table'
  classNames : [ "table", "table-condensed", "table-striped", "table-hover" ]
  template: Ember.Handlebars.compile(
    """
      <thead>
        <tr>
          <th>Nombre</th>
          <th>Tipo de pago</th>
          <th>Observaciones</th>
          <th>Monto</th>
          <th>&nbsp;</th>
        </tr>
      </thead>
      <tbody>
        {{#each model.alumnos}}
          {{ view App.ParticipanteView contentBinding="this" classNameBindings=this.infoLabel }}
        {{/each}}
      </tbody>
    """)

App.ParticipantesListView = Ember.View.extend
  elementId: 'participantes'
  tagName : 'table'
  classNames : [ "table", "table-condensed", "table-striped", "table-hover" ]
  template: Ember.Handlebars.compile(
    """
      <thead>
        <tr>
          <th>Nombre</th>
          <th>Tipo de pago</th>
          <th>Observaciones</th>
          <th>Monto</th>
          <th>&nbsp;</th>
        </tr>
      </thead>
      <tbody>
        {{#each controllers.cursosNuevos.currentCurso.alumnos}}
          {{ view App.ParticipanteView contentBinding="this" classNameBindings=this.isNew }}
        {{/each}}
      </tbody>
    """)

App.ParticipanteView = Ember.View.extend
  tagName : 'tr'
  template: Ember.Handlebars.compile('' +
    """
      <td> {{ nombreCompleto }} </td>
      <td> {{ tipoDePago }} </td>
      <td> {{ observaciones }} </td>
      <td> <span class="badge badge-info">${{ monto }}</span> </td>
      <td>
        {{#if id}} {{ view App.EncuestaButton class="btn btn-primary" }} {{/if}}
        {{#if id}} {{ view App.CertificadoPorParticipanteButton class="btn btn-success"}} {{/if}}
      </td>
    """ )

  click : (event) ->
    controller = @get('controller')
    controller.set('nombreCompleto', @get('context.nombreCompleto'))
    controller.set('observaciones', @get('context.observaciones'))

    tipoDePagoSelected = controller.get('tiposDePagos').findBy('id', @get('context.tipoDePago'))

    controller.set('tipoDePagoSelected', tipoDePagoSelected )
    controller.set('monto', @get('context.monto'))
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

App.EncuestaButton = Ember.View.extend(Ember.TargetActionSupport,
  tagName: 'a',
  classNames : ['btn btn-primary']
  iconName : "icon-edit icon-white"
  click: ->
    id = @get('context.id')
    urlSurveyBase = ($ "#surveyable").val()
    urlSurvey = "#{urlSurveyBase}/#{id}"

    window.open(urlSurvey)

  template: Ember.Handlebars.compile('<i {{bindAttr class="view.iconName"}}></i>')
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

App.CertificadoPorParticipanteButton = Ember.View.extend(Ember.TargetActionSupport,
  tagName: 'a',
  iconName : "icon-print icon-white"
  click: ->
    id = @get('context.id')

    urlBaseFrente = ($ '#frenteParaCursoPorAlumno').val()
    urlFrente = "#{urlBaseFrente}/#{id}"

    urlBaseReverso = ($ '#reversoParaCursoPorAlumno').val()
    urlReverso = "#{urlBaseReverso}/#{id}"

    window.open(urlFrente)
    window.open(urlReverso)
    return false

  template: Ember.Handlebars.compile('<i {{bindAttr class="view.iconName"}}></i>')
)

App.OficioButton = Ember.View.extend(Ember.TargetActionSupport,
  tagName: 'a',
  classNames: ['btn btn-primary']
  click: ->
    urlGenerarOficios = ($ '#generarOficios').val()
    dirigidoA = @get('context.dirigidoA')
    puesto = @get('context.puesto')
    deParteDe = @get('context.deParteDe.id')
    puerto = @get('context.puerto.id')
    desde = @get('context.desde')
    hasta = @get('context.hasta')

    window.open("#{urlGenerarOficios}?dirigidoA=#{dirigidoA}&puesto=#{puesto}&deParteDe=#{deParteDe}&puertoDeEnvio=#{puerto}&desde=#{desde}&hasta=#{hasta}")
    return false

  template: Ember.Handlebars.compile('Generar')
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

DragNDrop = Ember.Namespace.create()

DragNDrop.cancel = (event) ->
  event.preventDefault()
  return false

DragNDrop.Dragable = Ember.Mixin.create
  attributeBindings: ['draggable', 'style']
  draggable: 'true'
  style : 'cursor:move;'
  dragStart: (event) ->
    @set('style', 'cursor:move;opacity:0.4')
    $(".well").css
      "opacity" : '0.4'
      "background-image": "url('/images/arrastra_aqui.png')"
      "background-repeat":"no-repeat"
      "background-position":"center"

    dataTransfer = event.originalEvent.dataTransfer
    dataTransfer.setData('Text', @get('elementId'))
    @set('_context.isDragging', true)

  dragEnd : (event) ->
    @set('style', 'cursor:move;opacity:1.0')
    $(".well").css
      "opacity" : '1.0'
      "background-image": ""

DragNDrop.Droppable = Ember.Mixin.create
  dragEnter: DragNDrop.cancel
  dragOver: DragNDrop.cancel
  attributeBindings : "dropTarget"
  dropTarget : false
  drop: (event) ->
    event.preventDefault()
    return false

App.ListaAlumnosView = Ember.View.extend DragNDrop.Droppable,
  tagName : 'ul'
  classNames : "well"
  drop : (event) ->
    viewId = event.originalEvent.dataTransfer.getData('Text')
    view = Ember.View.views[viewId]
    dropTargetId = event.currentTarget.id

    if view.get('parentView.elementId') != dropTargetId
      ($ "#confirmarMovimientoDialog").modal(show:true)
      cursoProgramadoTarget = Ember.View.views[dropTargetId]
      view.set('_context.droppingTarget', cursoProgramadoTarget.get('content'))

    return this._super(event)

  template : Ember.Handlebars.compile("""
    {{#if view.content}}
      <dl class="dl-horizontal">
        <dt>Fecha de inicio</dt>
        <dd>{{ date view.content.fechaDeInicio }}</dd>

        <dt>Instructor</dt>
        <dd>{{ view.content.instructor.nombre }}</dd>

        <dt>Curso</dt>
        <dd>{{ view.content.curso.clave }}</dd>

        <dt>Puerto</dt>
        <dd>{{ view.content.puerto.descripcion }}</dd>
      </dl>
    {{/if}}

    {{#each view.content.alumnos}}
      <li> {{ view App.AlumnoDnDView }} {{ descripcion }} {{ view App.CertificadoPorParticipanteButton class='btn-link' iconName="icon-print" }} </li>
    {{/each}}
  """)

App.AlumnoDnDView = Ember.View.extend DragNDrop.Dragable,
  tagName : 'i'
  classNames : "icon-move"
  dragStart: (event) ->
    @_super(event)
    dataTransfer = event.originalEvent.dataTransfer
