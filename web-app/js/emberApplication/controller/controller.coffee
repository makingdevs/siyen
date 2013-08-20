App.CursosNuevosController = Ember.ArrayController.extend
  content : []

App.CursosNuevosCrearController = Ember.ObjectController.extend
  needs : ['cursosNuevos']
  instructores: []
  puertos : []
  cursos : []
  puertoSelected : null
  instructorSelected : null
  cursoSelected : null
  fechaDeInicio : null

  init : ->
      @._super()
      @.set 'instructores', App.Instructor.find()
      @.set 'puertos', App.Puerto.find()
      @.set 'cursos', App.Curso.find()

  crear : ->
    fechaDeInicio = moment(@.fechaDeInicio ? moment(), 'DD/MMMM/YYYY')
    cursosNuevosController = @.get('controllers.cursosNuevos')
    temporalId = cursosNuevosController.get('content.length') + 1

    cursoProgramado = App.CursoProgramado.createRecord
      id              : temporalId
      fechaDeInicio   : fechaDeInicio
      puerto          : @.puertoSelected
      instructor      : @.instructorSelected
      curso           : @.cursoSelected

    cursosNuevosController.get('content').pushObject(cursoProgramado)

    @.set('puertoSelected', null)
    @.set('instructorSelected', null)
    # @.set('cursoSelected', null)
    @.set('fechaDeInicio', moment().format('DD/MMMM/YYYY'))

    @.transitionToRoute('participante', cursoProgramado.id)

App.ParticipanteController = Ember.ObjectController.extend
  needs : ['cursosNuevos']
  content : []
  nombreCompleto : null
  observaciones : null

  agregar : ->
    cursosNuevosController = @.get('controllers.cursosNuevos')
    cursoProgramado = cursosNuevosController.get('content').get(@.get('content') - 1)

    alumno = App.Alumno.createRecord
      nombreCompleto : @.get('nombreCompleto')
      observaciones : @.get('observaciones')

    cursoProgramado.get('alumnos').pushObject(alumno)

  participantes : (->
    cursosNuevosController = @.get('controllers.cursosNuevos')
    cursoProgramado = cursosNuevosController.get('content').get(@.get('content') - 1)
    cursoProgramado.get('alumnos')
  ).property("cursoProgramado.alumnos")