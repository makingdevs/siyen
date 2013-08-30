App.CursosNuevosController = Ember.ArrayController.extend
  content : []
  currentCurso : null
  autorizarCurso : null

  currentCursoObserves : (->
    @.transitionToRoute('crear.participantes') if @.currentCurso
  ).observes('currentCurso')

  autorizar : ->
    ($ "#confirmarAutorizacionDialog").modal( show: true )

  doCancelAutorizacion : ->
    ($ "#confirmarAutorizacionDialog").modal('hide')
    @.set( 'autorizarCurso', null )

  doRealizarAutorizacion : ->
    cursoAutorizado = @.get('autorizarCurso')
    
    transaction = @store.transaction()
    cursoProgramado = transaction.createRecord( App.CursoProgramado,
      fechaDeInicio : cursoAutorizado.get('fechaDeInicio').format('DD/MMMM/YYYY')
      puerto : cursoAutorizado.get('puerto')
      instructor : cursoAutorizado.get('instructor')
      curso : cursoAutorizado.get('curso') )

    for alumno in cursoAutorizado.get('alumnos')
      cursoProgramado.get('alumnos').createRecord
        nombreCompleto : alumno.get('nombreCompleto')
        observaciones : alumno.get('observaciones')

    ($ "#confirmarAutorizacionDialog").modal('hide')
    transaction.commit()

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

  currentCursoObserves : (->
    cursosNuevosController = @.get('controllers.cursosNuevos')
    currentCurso = cursosNuevosController.get('currentCurso')

    if currentCurso
      @.set("fechaDeInicio", currentCurso.get('fechaDeInicio').format('DD/MMMM/YYYY'))
      @.set("puertoSelected", currentCurso.get('puerto'))
      @.set("instructorSelected", currentCurso.get('instructor'))
      @.set("cursoSelected", currentCurso.get('curso'))

  ).observes('controllers.cursosNuevos.currentCurso')

  init : ->
    @._super()
    @.set 'instructores', App.Instructor.find()
    @.set 'puertos', App.Puerto.find()
    @.set 'cursos', App.Curso.find()

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

    @.transitionToRoute('cursosNuevos.index')

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

  agregar : ->
    currentCurso = @.get('controllers.cursosNuevos').get('currentCurso')
    currentCurso.get('alumnos').pushObject(Ember.Object.create
      nombreCompleto : @.nombreCompleto
      observaciones : @.observaciones
    )

    @.set("nombreCompleto", null)
    @.set("observaciones", null)

App.ArchivoController = Ember.ObjectController.extend

  participantes : []

  procesarArchivo : ->
    dropzone = Dropzone.forElement("div#dropzone.dropzone")
    dropzone.processQueue()

    dropzone.on "success", (file, response) =>
      file.previewElement.classList.add("dz-success")
      for fila in response.contenidoDeFilas
        @.participantes.pushObject( Ember.Object.create
          nombreCompleto : fila.get(1)
          observaciones : fila.get(2)
        )