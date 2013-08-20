App.CursosNuevosController = Ember.ArrayController.extend
  content : []

App.CurrentCursoNuevoController = Ember.ObjectController.extend
  needs : "cursosNuevos"
  contentBinding : 'cursosNuevosController.cursoNuevo'
  cursosNuevosController : null

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
    @.set 'instructores', App.Instructor.find()
    @.set 'puertos', App.Puerto.find()
    @.set 'cursos', App.Curso.find()

  crear : ->
    cursosNuevosController = @.get('controllers.cursosNuevos')
    content = cursosNuevosController.get('content')

    content.pushObject(Ember.Object.create(
      "fechaDeInicio": moment(@.fechaDeInicio ? moment(), 'DD/MMMM/YYYY')
      "puerto" : @.get('puertoSelected')
      "instructor" : @.get('instructorSelected')
      "curso" : @.get('cursoSelected')
      "alumnos" : []
      "currentCurso" : true
    ))

    # @.transitionToRoute('crear.participantes')