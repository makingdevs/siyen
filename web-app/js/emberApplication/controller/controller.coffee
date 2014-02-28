App.BusquedaForGetType = Ember.Mixin.create
  busquedaGetWithSelector : (selector) ->
    $("body").on "click", selector, (event) ->
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

App.CursosNuevosController = Ember.ArrayController.extend App.BusquedaForGetType,
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
      ($ "#primary").attr('disabled', true)
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
          tipoDePago : alumno.get('tipoDePago')
          monto : alumno.get('monto')
        )

      cursoProgramado.save().then(
        (value) =>
          ($ "#primary").attr('disabled', false)
          ($ "#confirmarAutorizacionDialog").modal('hide')
          @content.removeObject(@get('autorizarCurso'))
          @transitionToRoute('cursosAutorizados')

        (reason) =>
          ($ "#primary").attr('disabled', false)
          cursoProgramado.rollback()
          ($ "#confirmarAutorizacionDialog").modal('hide')
          jsonData = eval('(' + reason.responseText + ')')
          cursos = "#{jsonData.curso},"
          puertos = "#{jsonData.puerto},"
          instructores = "#{jsonData.instructor},"
          desde = moment(jsonData.fechaDeInicio, "YYYY-MM-DD").format('DD/MM/YYYY')
          hasta = moment(jsonData.fechaDeTermino, "YYYY-MM-DD").format('DD/MM/YYYY')

          ($ "#duplicacion > .modal-body").html("""
            <p> Se ha encontrado un curso con los mismos datos : </p>

            <dl class="dl-horizontal">
              <dt>Fecha de inicio</dt>
              <dd>#{desde}</dd>

              <dt>Fecha de término</dt>
              <dd>#{hasta}</dd>

              <dt>Instructor</dt>
              <dd>#{instructores.replace(',', '')}</dd>

              <dt>Curso</dt>
              <dd>#{cursos.replace(',', '')}</dd>

              <dt>Puerto</dt>
              <dd>#{puertos.replace(',', '')}</dd>
            </dl>
          """)

          ($ "#duplicacion > .modal-footer").html("""
            <a href="/busqueda/realizarBusqueda?buscar=&cursos=#{cursos}&puertos=#{puertos}&instructores=#{instructores}&desde=#{desde}&hasta=#{hasta}&offset=0&max=10" id="busqueda" class="btn btn-primary"> Ver los datos duplicados </a>
          """)

          @busquedaGetWithSelector("#busqueda")

          $("body").on "click", "#busqueda", (event) =>
            $("#duplicacion").modal('hide')
            @transitionToRoute('busqueda')

          ($ "#duplicacion").modal('show')
      )

App.CursosAutorizadosController = Ember.ArrayController.extend()

App.EditController = Ember.ObjectController.extend
  cursos : []

  fechaDeInicio : null
  nombreCompleto : null
  observaciones : null
  monto : null
  tipoDePago : null
  currentParticipanteIndex : -1
  disabled : false

  tiposDePagos : [
    { id:'EFECTIVO', name:'Efectivo' },
    { id:'BECADO', name:'Becado' },
    { id:'DEPOSITO_BANCARIO', name:'Depósito Bancario' }
  ]
  tipoDePagoSelected : null

  alumnosAddObserves : (->
    @set('disabled', true) if @get('model.alumnosRestantes') <= 0
  ).observes('model.alumnosRestantes')

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

      unless @tipoDePagoSelected
        ($ "#error .message").text('El tipo de pago es obligatorio')
        ($ "#error").fadeIn 'slow', ->
          ($ @).delay(3000).fadeOut('slow')
        return

      switch @tipoDePagoSelected.id
        when "EFECTIVO", "DEPOSITO_BANCARIO"
          if @monto <= 0
            ($ "#error .message").text('El campo de monto es obligatorio')
            ($ "#error").fadeIn 'slow', ->
              ($ @).delay(3000).fadeOut('slow')
            return
        when 'BECADO'
          unless @observaciones
            ($ "#error .message").text('El campo de observaciones es obligatorio')
            ($ "#error").fadeIn 'slow', ->
              ($ @).delay(3000).fadeOut('slow')
            return

      alumno.set 'nombreCompleto', @nombreCompleto
      alumno.set 'tipoDePago', @tipoDePagoSelected.id
      alumno.set 'observaciones', @observaciones
      alumno.set 'monto', @monto
      alumno.set 'cursoProgramado', cursoProgramado

      alumno.save().then(
        (success) ->
          ($ ".info").first().removeClass('info')
          ($ ".#{success.get('id')}").first().addClass('info')
          cursoProgramado.decrementProperty('alumnosRestantes')
        (reason) ->
          alumno.rollback()
          jsonData = eval('(' + reason.responseText + ')')

          ($ "#alertas strong").text('ERROR')
          ($ "#alertas .message").text(jsonData.message)
          ($ "#alertas").attr("class", "alert alert-error")
          ($ "#alertas").fadeIn 'slow', ->
            ($ @).delay(5000).fadeOut('slow')
      )

      @setProperties
        currentParticipanteIndex : -1
        tipoDePagoSelected : null
        nombreCompleto : null
        observaciones : null
        monto : null

App.EditParticipantesController = Ember.ObjectController.extend()

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

      unless @get('puertoSelected')
        ($ "#error .message").text('El puerto es obligatorio')
        ($ "#error").fadeIn 'slow', ->
          ($ @).delay(3000).fadeOut('slow')
        return

      unless @get('instructorSelected')
        ($ "#error .message").text('El instructor es obligatorio')
        ($ "#error").fadeIn 'slow', ->
          ($ @).delay(3000).fadeOut('slow')
        return

      unless @get('cursoSelected')
        ($ "#error .message").text('El curso es obligatorio')
        ($ "#error").fadeIn 'slow', ->
          ($ @).delay(3000).fadeOut('slow')
        return

      if cursosNuevosController.get('currentCurso')
        cursoProgramado = cursosNuevosController.get('currentCurso')
        cursoProgramado.setProperties(
          "fechaDeInicio": moment(@fechaDeInicio ? moment(), 'DD/MMMM/YYYY')
          "puerto" : @get('puertoSelected')
          "instructor" : @get('instructorSelected')
          "curso" : @get('cursoSelected')
        )
        return

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
  monto : 0

  tiposDePagos : [
    { id:'EFECTIVO', name:'Efectivo' },
    { id:'BECADO', name:'Becado' },
    { id:'DEPOSITO_BANCARIO', name:'Depósito Bancario' }
  ]
  tipoDePagoSelected : null

  currentParticipanteIndex : -1

  currentCursoObserves : (->
    cursosNuevosController = @get('controllers.cursosNuevos')
    currentCurso = cursosNuevosController.get('currentCurso')

    if currentCurso
      @setProperties
        nombreCompleto: null
        observaciones: null
        tipoDePagoSelected : null
        monto: null

  ).observes('controllers.cursosNuevos.currentCurso')

  actions :
    agregar : ->
      currentCurso = @get('controllers.cursosNuevos').get('currentCurso')

      unless @tipoDePagoSelected
        ($ "#error .message").text('El tipo de pago es obligatorio')
        ($ "#error").fadeIn 'slow', ->
          ($ @).delay(3000).fadeOut('slow')
        return

      alumno = Ember.Object.create
        nombreCompleto : @nombreCompleto
        tipoDePago : @tipoDePagoSelected.id
        observaciones : @observaciones
        monto : @monto
        isNew : 'info'

      switch @tipoDePagoSelected.id
        when "EFECTIVO", "DEPOSITO_BANCARIO"
          if @monto <= 0
            ($ "#error .message").text('El campo de monto es obligatorio')
            ($ "#error").fadeIn 'slow', ->
              ($ @).delay(3000).fadeOut('slow')
            return
        when 'BECADO'
          unless @observaciones
            ($ "#error .message").text('El campo de observaciones es obligatorio')
            ($ "#error").fadeIn 'slow', ->
              ($ @).delay(3000).fadeOut('slow')
            return

      currentCurso.get('alumnos').findBy('isNew', 'info').set('isNew', '') if currentCurso.get('alumnos').length
      if @currentParticipanteIndex >= 0
        currentCurso.get('alumnos').replace(@currentParticipanteIndex, 1, [alumno])
      else
        currentCurso.get('alumnos').pushObject(alumno)

      @set('currentParticipanteIndex', -1)
      @setProperties
        nombreCompleto: null
        observaciones: null
        tipoDePagoSelected : null
        monto: null

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
      @send('limpiarProceso')
      @transitionToRoute('cursosNuevos.index')

    limpiarProceso : ->
      @setProperties
        fechaDeInicio : null
        puertoSelected : null
        instructorSelected : null
        cursoSelected : null
        participantes : []
      dropzone = Dropzone.forElement("div#dropzone.dropzone")
      dropzone.removeAllFiles(true)

App.NotificacionController = Ember.ArrayController.extend
  content : []

  init : ->
    @_super()
    eventBusURL = ($ '#eventBusURL').val()
    eventBus = new vertx.EventBus(eventBusURL)

    eventBus.onopen = =>
      console.log "Event Bus connected"

      eventBus.registerHandler('cursoProgramado.autorizado', (jsonMessage) =>
        crearNotificacionConRespuesta(jsonMessage)
      )

      eventBus.registerHandler('cursoProgramado.impresion', (jsonMessage) =>
        crearNotificacionConRespuesta(jsonMessage)
      )

      eventBus.registerHandler('cursoProgramado.impresion_de', (jsonMessage) =>
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

App.BusquedaController = Ember.ObjectController.extend App.BusquedaForGetType,
  busqueda : null
  urlBusqueda : null
  desde : null
  hasta : null

  init : ->
    @set('urlBusqueda', $("#urlBusqueda").val())
    @busquedaGetWithSelector('.pagination li a')

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

App.AlumnosController = Ember.ObjectController.extend App.BusquedaForGetType,
  busquedaDeAlumno : null
  urlBusquedaDeAlumnos : null

  init : ->
    @set('urlBusquedaDeAlumnos', $("#urlBusquedaDeAlumnos").val())
    @busquedaGetWithSelector('.pagination li a')

  actions :
    realizarBusqueda : ->
      busqueda = @get('busquedaDeAlumno')

      $.ajax(
        type: "POST"
        url: @get('urlBusquedaDeAlumnos')
        data:
          buscar : busqueda
        success: (res, status, xhr) ->
          $("#resultados").html( res )
        error: (xhr, status, err) ->
          console.log "error"
      )

App.MovimientosController = Ember.ObjectController.extend
  actions :
    doRealizarMovimiento : ->
      currentDragAlumno = @get('cursoSelectedA.currentDragItem') if @get('cursoSelectedA.currentDragItem')
      currentDragAlumno = @get('cursoSelectedB.currentDragItem') if @get('cursoSelectedB.currentDragItem')
      cursoProgramadoOriginal = currentDragAlumno.get('cursoProgramado')
      currentDragAlumno.set('cursoProgramado', currentDragAlumno.get('droppingTarget'))

      currentDragAlumno.save().then(
        (success) ->
          ($ "#alertas strong").text('ÉXITO')
          ($ "#alertas .message").text("El cambio se ha realizado satisfactoriamente.")
          ($ "#alertas").attr("class", "alert alert-success")
          ($ "#alertas").fadeIn 'slow', ->
            ($ @).delay(3000).fadeOut('slow')

        (reason) ->
          currentDragAlumno.set('cursoProgramado', cursoProgramadoOriginal)
          currentDragAlumno.rollback()
          jsonData = eval('(' + reason.responseText + ')')

          ($ "#alertas strong").text('ERROR')
          ($ "#alertas .message").text(jsonData.message)
          ($ "#alertas").attr("class", "alert alert-error")
          ($ "#alertas").fadeIn 'slow', ->
            ($ @).delay(3000).fadeOut('slow')
      )
      currentDragAlumno.setProperties
        'isDragging' : false
        'droppingTarget', null
      ($ "#confirmarMovimientoDialog").modal('hide')

    doCancelMovimiento : ->
      ($ "#confirmarMovimientoDialog").modal('hide')

App.OficiosController = Ember.ObjectController.extend
  instructores : []
  puertos : []

  dirigidoA : null
  puesto : null
  puerto : null
  deParteDe : null
  desde : null
  hasta : null

App.AlumnoController = Ember.ObjectController.extend App.BusquedaForGetType,
  cursos : []
  needs : ['alumnos']
  init : ->
    @_super()
    @set 'cursos', @get('store').find("curso")

  actions :
    realizarMovimiento : ->
      ($ "#movimientoConfirmDialog").modal( show: true )

    doCancelarMovimiento : ->
      ($ "#movimientoConfirmDialog").modal('hide')

    doConfirmarMovimiento : ->
      cursoProgramado = @store.createRecord('cursoProgramado',
        fechaDeInicio : moment(@get('cursoProgramado.fechaDeInicio')).format('DD/MM/YYYY')
        puerto: @get('cursoProgramado.puerto')
        curso : @get('cursoProgramado.curso')
        instructor : @get('cursoProgramado.instructor')
      )
      cursoProgramado.get('alumnos').createRecord(
        numeroDeControl : @get('numeroDeControl')
        nombreCompleto : @get('nombreCompleto')
        observaciones : @get('observaciones')
        monto : @get('monto')
      )
      cursoProgramado.save().then(
        (value) =>
          ($ "#movimientoConfirmDialog").modal('hide')
          ($ "#alertas strong").text('ÉXITO')
          ($ "#alertas .message").text("El cambio se ha realizado satisfactoriamente.")
          ($ "#alertas").attr("class", "alert alert-success")
          ($ "#alertas").fadeIn 'slow', ->
            ($ @).delay(5000).fadeOut('slow')

          alumnosController = @get('controllers.alumnos')
          alumnosController.send('realizarBusqueda')
          @transitionToRoute('alumnos')

        (reason) =>
          cursoProgramado.rollback()
          ($ "#movimientoConfirmDialog").modal('hide')
          jsonData = eval('(' + reason.responseText + ')')
          cursos = "#{jsonData.curso},"
          puertos = "#{jsonData.puerto},"
          instructores = "#{jsonData.instructor},"
          desde = moment(jsonData.fechaDeInicio, "YYYY-MM-DD").format('DD/MM/YYYY')
          hasta = moment(jsonData.fechaDeTermino, "YYYY-MM-DD").format('DD/MM/YYYY')

          ($ "#duplicacion > .modal-body").html("""
            <p> Se ha encontrado un curso con los mismos datos : </p>

            <dl class="dl-horizontal">
              <dt>Fecha de inicio</dt>
              <dd>#{desde}</dd>

              <dt>Fecha de término</dt>
              <dd>#{hasta}</dd>

              <dt>Instructor</dt>
              <dd>#{instructores.replace(',', '')}</dd>

              <dt>Curso</dt>
              <dd>#{cursos.replace(',', '')}</dd>

              <dt>Puerto</dt>
              <dd>#{puertos.replace(',', '')}</dd>
            </dl>
          """)

          ($ "#duplicacion > .modal-footer").html("""
            <a href="/busqueda/realizarBusqueda?buscar=&cursos=#{cursos}&puertos=#{puertos}&instructores=#{instructores}&desde=#{desde}&hasta=#{hasta}&offset=0&max=10" id="busqueda" class="btn btn-primary"> Ver los datos duplicados </a>
          """)

          @busquedaGetWithSelector("#busqueda")

          $("body").on "click", "#busqueda", (event) =>
            $("#duplicacion").modal('hide')
            @transitionToRoute('busqueda')

          ($ "#duplicacion").modal('show')
      )
      ($ "#primary").attr('disabled', false)
