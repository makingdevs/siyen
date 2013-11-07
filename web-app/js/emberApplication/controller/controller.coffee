App.CursosNuevosController = Ember.ArrayController.extend
  content : []
  currentCurso : null
  autorizarCurso : null

  currentCursoObserves : (->
    @transitionToRoute('crear.participantes') if @currentCurso
  ).observes('currentCurso')

  autorizar : ->
    ($ "#confirmarAutorizacionDialog").modal( show: true )

  actions :
    doCancelAutorizacion : ->
      ($ "#confirmarAutorizacionDialog").modal('hide')
      @set( 'autorizarCurso', null )

    doRealizarAutorizacion : ->
      cursoProgramadoTemp = @get('autorizarCurso')

      cursoProgramadoLocal = {
        fechaDeInicio : cursoProgramadoTemp.get('fechaDeInicio').format('DD/MMMM/YYYY')
        puerto : cursoProgramadoTemp.get('puerto')
        instructor : cursoProgramadoTemp.get('instructor')
        curso : cursoProgramadoTemp.get('curso')
      }

      cursoProgramado = @store.createRecord('cursoProgramado', cursoProgramadoLocal)
      for alumno in cursoProgramadoTemp.get('alumnos')
        cursoProgramado.get('alumnos').createRecord(
          nombreCompleto : alumno.get('nombreCompleto')
          observaciones : alumno.get('observaciones')
        )

      cursoProgramado.save().then(
        (value) =>
          ($ "#confirmarAutorizacionDialog").modal('hide')
          @content.removeObject(@get('autorizarCurso'))
          @transitionToRoute('cursosAutorizados')

        ->
          console.log "failed"
      )

App.CursosAutorizadosController = Ember.ArrayController.extend()

App.EditController = Ember.ObjectController.extend
  cursos : []

  fechaDeInicio : null
  nombreCompleto : null
  observaciones : null
  currentParticipanteIndex : -1

  init : ->
    @_super()
    @set 'cursos', @get('store').find("curso")

  actions :

    actualizarCurso : ->
      cursoProgramado = @get('model')
      cursoProgramado.save()

    actualizar : ->
      cursoProgramado = @get('model')

      if @currentParticipanteIndex >= 0
        alumno = cursoProgramado.get('alumnos').objectAt(@currentParticipanteIndex)
      else 
        alumno = @store.createRecord('alumno')

      alumno.set('nombreCompleto', @nombreCompleto)
      alumno.set('observaciones', @observaciones)
      alumno.set('cursoProgramado', cursoProgramado)
      alumno.save()

      @set('currentParticipanteIndex', -1)
      @set("nombreCompleto", null)
      @set("observaciones", null)

App.EditParticipantesController = Ember.ObjectController.extend()

App.CursosNuevosCrearController = Ember.ObjectController.extend()

App.CrearController = Ember.ObjectController.extend
  needs : ["cursosNuevos"]
  instructores : []
  puertos : []
  cursos : []

  fechaDeInicio : null
  puertoSelected : null
  instructorSelected : null
  cursoSelected : null

  init : ->
    @_super()
    @set 'instructores', @get('store').find("instructor")
    @set 'puertos', @get('store').find("puerto")
    @set 'cursos', @get('store').find("curso")

  currentCursoObserves : (->
    cursosNuevosController = @get('controllers.cursosNuevos')
    currentCurso = cursosNuevosController.get('currentCurso')

    if currentCurso
      @set("fechaDeInicio", currentCurso.get('fechaDeInicio').format('DD/MMMM/YYYY'))
      @set("puertoSelected", currentCurso.get('puerto'))
      @set("instructorSelected", currentCurso.get('instructor'))
      @set("cursoSelected", currentCurso.get('curso'))

  ).observes('controllers.cursosNuevos.currentCurso')

  actions :

    crear : ->
      cursosNuevosController = @get('controllers.cursosNuevos')
      content = cursosNuevosController.get('content')

      cursoProgramado = Ember.Object.create
        "fechaDeInicio": moment(@fechaDeInicio ? moment(), 'DD/MMMM/YYYY')
        "puerto" : @get('puertoSelected')
        "instructor" : @get('instructorSelected')
        "curso" : @get('cursoSelected')
        "alumnos" : []

      content.pushObject( cursoProgramado )
      cursosNuevosController.set( 'currentCurso', cursoProgramado )

    finalizar : ->
      cursosNuevosController = @get('controllers.cursosNuevos')
      cursosNuevosController.set( 'currentCurso', null )

      @set("fechaDeInicio", moment().format('DD/MMMM/YYYY'))
      @set("puertoSelected", null)
      @set("instructorSelected", null)
      @set("cursoSelected", null)

      @transitionToRoute('cursosNuevos.index')

App.CrearParticipantesController = Ember.ObjectController.extend
  needs : "cursosNuevos"

  nombreCompleto : null
  observaciones : null

  currentParticipanteIndex : -1

  currentCursoObserves : (->
    cursosNuevosController = @get('controllers.cursosNuevos')
    currentCurso = cursosNuevosController.get('currentCurso')

    if currentCurso
      @set("nombreCompleto", null)
      @set("observaciones", null)

  ).observes('controllers.cursosNuevos.currentCurso')

  actions :
    agregar : ->
      currentCurso = @get('controllers.cursosNuevos').get('currentCurso')
      alumno = Ember.Object.create
        nombreCompleto : @nombreCompleto
        observaciones : @observaciones

      if @currentParticipanteIndex >= 0
        currentCurso.get('alumnos').replace(@currentParticipanteIndex, 1, [alumno])
      else
        currentCurso.get('alumnos').pushObject(alumno)

      @set('currentParticipanteIndex', -1)
      @set("nombreCompleto", null)
      @set("observaciones", null)

App.ArchivoController = Ember.ObjectController.extend
  needs : ["cursosNuevos"]
  instructores : []
  puertos : []
  cursos : []

  fechaDeInicio : null
  puertoSelected : null
  instructorSelected : null
  cursoSelected : null

  participantes : []

  init : ->
    @_super()
    @set 'instructores', @get('store').find("instructor")
    @set 'puertos', @get('store').find("puerto")
    @set 'cursos', @get('store').find("curso")

  actions :
    procesarArchivo : ->
      dropzone = Dropzone.forElement("div#dropzone.dropzone")
      dropzone.processQueue()

      dropzone.on "success", (file, response) =>
        file.previewElement.classList.add("dz-success")
        for fila in response.contenidoDeFilas
          @participantes.pushObject( Ember.Object.create
            nombreCompleto : fila.get(1)
            observaciones : $.trim(fila.get(2))
          )

    finalizar : ->
      cursosNuevosController = @get('controllers.cursosNuevos')
      content = cursosNuevosController.get('content')

      cursoProgramado = Ember.Object.create
        "fechaDeInicio": moment(@fechaDeInicio ? moment(), 'DD/MMMM/YYYY')
        "puerto" : @get('puertoSelected')
        "instructor" : @get('instructorSelected')
        "curso" : @get('cursoSelected')
        "alumnos" : @get('participantes')

      content.pushObject( cursoProgramado )
      cursosNuevosController.set( 'currentCurso', null )
      console.log cursoProgramado
      @transitionToRoute('cursosNuevos.index')

App.NotificacionController = Ember.ArrayController.extend
  content : []

  init : ->
    @_super()
    eventBus = new vertx.EventBus('http://localhost:9090/eventbus')

    eventBus.onopen = =>
      console.log "Event Bus connected"

      eventBus.registerHandler('cursoProgramado.autorizado', (jsonMessage) =>
        crearNotificacionConRespuesta(jsonMessage)
      )

      eventBus.registerHandler('cursoProgramado.impresion', (jsonMessage) =>
        crearNotificacionConRespuesta(jsonMessage)
      )

      eventBus.registerHandler('cursoProgramado.actualizado', (jsonMessage) =>
        crearNotificacionConRespuesta(jsonMessage)
      )

      eventBus.registerHandler('cursoProgramado.alumno_add', (jsonMessage) =>
        crearNotificacionConRespuesta(jsonMessage)
      )

      eventBus.registerHandler('cursoProgramado.alumno_edit', (jsonMessage) =>
        crearNotificacionConRespuesta(jsonMessage)
      )

    crearNotificacionConRespuesta = (jsonMessage) =>
      notificacion = Ember.Object.create
        id : jsonMessage.id
        fechaDeAutorizacion : jsonMessage.fechaDeAutorizacion
        fechaDeInicio : jsonMessage.fechaDeInicio
        puerto : jsonMessage.puerto
        curso : jsonMessage.curso
        instructor : jsonMessage.instructor
        alumnos : jsonMessage.alumnos
        creadoPor : jsonMessage.creadoPor
        accion : jsonMessage.accion

      @content.pushObject(notificacion)

App.BusquedaController = Ember.ObjectController.extend
  urlBusqueda : null

  init : ->
    @set('urlBusqueda', $("#urlBusqueda").val())

  actions :
    realizarBusqueda : ->
      busqueda = $("#busquedaChosen").val().toString()

      $.ajax(
        type: "POST"
        url: @get('urlBusqueda')
        data: { buscar : busqueda }
        success: (res, status, xhr) ->
          $("#resultados").html( res )

        error: (xhr, status, err) ->
          console.log "error"
      )