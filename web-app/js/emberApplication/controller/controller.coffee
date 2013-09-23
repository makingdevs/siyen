App.CursosNuevosController = Ember.ArrayController.extend
  content : []
  currentCurso : null
  autorizarCurso : null

  currentCursoObserves : (->
    @.transitionToRoute('crear.participantes') if @.currentCurso
  ).observes('currentCurso')

  autorizar : ->
    ($ "#confirmarAutorizacionDialog").modal( show: true )

  actions :
    doCancelAutorizacion : ->
      ($ "#confirmarAutorizacionDialog").modal('hide')
      @.set( 'autorizarCurso', null )

    doRealizarAutorizacion : ->
      cursoProgramadoTemp = @.get('autorizarCurso')

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
    @._super()
    @.set 'instructores', @get('store').find("instructor")
    @.set 'puertos', @get('store').find("puerto")
    @.set 'cursos', @get('store').find("curso")

  currentCursoObserves : (->
    cursosNuevosController = @.get('controllers.cursosNuevos')
    currentCurso = cursosNuevosController.get('currentCurso')

    if currentCurso
      @.set("fechaDeInicio", currentCurso.get('fechaDeInicio').format('DD/MMMM/YYYY'))
      @.set("puertoSelected", currentCurso.get('puerto'))
      @.set("instructorSelected", currentCurso.get('instructor'))
      @.set("cursoSelected", currentCurso.get('curso'))

  ).observes('controllers.cursosNuevos.currentCurso')

  actions :

    crear : ->
      cursosNuevosController = @.get('controllers.cursosNuevos')
      content = cursosNuevosController.get('content')

      cursoProgramado = Ember.Object.create
        "fechaDeInicio": moment(@.fechaDeInicio ? moment(), 'DD/MMMM/YYYY')
        "puerto" : @.get('puertoSelected')
        "instructor" : @.get('instructorSelected')
        "curso" : @.get('cursoSelected')
        "alumnos" : []

      content.pushObject( cursoProgramado )
      cursosNuevosController.set( 'currentCurso', cursoProgramado )

    finalizar : ->
      cursosNuevosController = @.get('controllers.cursosNuevos')
      cursosNuevosController.set( 'currentCurso', null )

      @.set("fechaDeInicio", moment().format('DD/MMMM/YYYY'))
      @.set("puertoSelected", null)
      @.set("instructorSelected", null)
      @.set("cursoSelected", null)

      @transitionToRoute('cursosNuevos.index')

App.CrearParticipantesController = Ember.ObjectController.extend
  needs : "cursosNuevos"

  nombreCompleto : null
  observaciones : null

  currentCursoObserves : (->
    cursosNuevosController = @.get('controllers.cursosNuevos')
    currentCurso = cursosNuevosController.get('currentCurso')

    if currentCurso
      @.set("nombreCompleto", null)
      @.set("observaciones", null)

  ).observes('controllers.cursosNuevos.currentCurso')

  actions :
    agregar : ->
      currentCurso = @.get('controllers.cursosNuevos').get('currentCurso')
      currentCurso.get('alumnos').pushObject(Ember.Object.create
        nombreCompleto : @.nombreCompleto
        observaciones : @.observaciones
      )

      @.set("nombreCompleto", null)
      @.set("observaciones", null)

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
    @._super()
    @.set 'instructores', @get('store').find("instructor")
    @.set 'puertos', @get('store').find("puerto")
    @.set 'cursos', @get('store').find("curso")

  actions :
    procesarArchivo : ->
      dropzone = Dropzone.forElement("div#dropzone.dropzone")
      dropzone.processQueue()

      dropzone.on "success", (file, response) =>
        file.previewElement.classList.add("dz-success")
        for fila in response.contenidoDeFilas
          @.participantes.pushObject( Ember.Object.create
            nombreCompleto : fila.get(1)
            observaciones : $.trim(fila.get(2))
          )

    finalizar : ->
      cursosNuevosController = @.get('controllers.cursosNuevos')
      content = cursosNuevosController.get('content')

      cursoProgramado = Ember.Object.create
        "fechaDeInicio": moment(@.fechaDeInicio ? moment(), 'DD/MMMM/YYYY')
        "puerto" : @get('puertoSelected')
        "instructor" : @get('instructorSelected')
        "curso" : @get('cursoSelected')
        "alumnos" : @get('participantes')

      content.pushObject( cursoProgramado )
      cursosNuevosController.set( 'currentCurso', null )
      @transitionToRoute('cursosNuevos.index')
