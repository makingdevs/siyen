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
        fechaDeInicio : cursoProgramadoTemp.get('fechaDeInicio').format('DD/MM/YYYY')
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

        (reason) =>
          ($ "#confirmarAutorizacionDialog").modal('hide')
          jsonData = eval('(' + reason.responseText + ')')
          ($ "#duplicacion > .modal-body").html("""
          <p> Se ha encontrado un curso con los mismos datos : </p>
            <p> Fecha de inicio : #{jsonData.fechaDeInicio} </p>
            <p> Fecha de término : #{jsonData.fechaDeTermino} </p>
            <p> Instructor : #{jsonData.instructor} </p>
            <p> Curso : #{jsonData.curso} </p>
            <p> Puerto : #{jsonData.puerto} </p>
            <a href="#/busqueda" id="busqueda"> Busqueda </a>
          """)

          $("body").on "click", "#busqueda", (event) =>
            event.preventDefault()
            busqueda = $("#urlBusqueda").val()
            cursos = "#{jsonData.curso},"
            puertos = "#{jsonData.puerto},"
            instructores = "#{jsonData.instructor},"
            desde = moment(jsonData.fechaDeInicio, "YYYY-MM-DD").format('DD/MM/YYYY')
            hasta = moment(jsonData.fechaDeTermino, "YYYY-MM-DD").format('DD/MM/YYYY')
            $("#duplicacion").modal('hide')
            @transitionToRoute('busqueda')

            $.ajax(
              type: "POST"
              url: busqueda
              data:
                buscar : ""
                cursos : cursos
                puertos : puertos
                instructores : instructores
                desde : desde
                hasta : hasta
              success: (res, status, xhr) =>
                $("#resultados").html( res )
                $("#busquedaAvanzada").hide()
              error: (xhr, status, err) ->
                console.log "error"
            )
          ($ "#duplicacion").modal('show')
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
    eventBus = new vertx.EventBus('http://localhost:9091/eventbus')

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
  busqueda : null
  urlBusqueda : null
  desde : null
  hasta : null

  init : ->
    @set('urlBusqueda', $("#urlBusqueda").val())

    $("body").on "click", ".pagination li a", (event) ->
      event.preventDefault()
      $.ajax(
        type: "GET"
        url: event.target
        success: (res, status, xhr) ->
          $("#resultados").html( res )
          $("#busquedaAvanzada").hide()
        error: (xhr, status, err) ->
          console.log "error"
      )

  actions :
    realizarBusqueda : ->
      busqueda = @get('busqueda')
      cursos = $("#cursos").val()?.toString()
      puertos = $("#puertos").val()?.toString()
      instructores = $("#instructores").val()?.toString()

      if @get('desde') && @get('hasta')
        desde = moment(@get('desde'), "DD/MMM/YYYY").format('DD/MM/YYYY')
        hasta = moment(@get('hasta'), "DD/MMM/YYYY").format('DD/MM/YYYY')

      $.ajax(
        type: "POST"
        url: @get('urlBusqueda')
        data:
          buscar : busqueda
          cursos : cursos
          puertos : puertos
          instructores : instructores
          desde : desde
          hasta : hasta
        success: (res, status, xhr) ->
          $("#resultados").html( res )
          $("#busquedaAvanzada").hide()
        error: (xhr, status, err) ->
          console.log "error"
      )
