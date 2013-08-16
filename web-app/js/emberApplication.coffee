window.App = Ember.Application.create()

App.Router.map -> 
  @.resource 'cursosNuevos'

  @.resource 'cursosProgramados', ->
    @.route 'nuevo'
    @.resource('cursoProgramado', { path : ':curso_programado_id' } )


App.CursosProgramadosRoute = Ember.Route.extend
  model: ->
    App.CursoProgramado.find()

App.CursosProgramadosNuevoController = Ember.ObjectController.extend
  instructores: []
  puertos : []
  cursos : []
  puertoSelected : null
  instructorSelected : null
  cursoSelected : null
  fechaDeInicio : null

  guardar : ->
    fechaDeInicio = moment(@.fechaDeInicio ? moment(), 'DD/MMMM/YYYY')
    fechaDeTermino = moment(fechaDeInicio).add('days', @.cursoSelected.get('duracion'))

    cursoProgramado = App.CursoProgramado.createRecord
      fechaDeInicio   : fechaDeInicio
      fechaDeTermino  : fechaDeTermino
      puerto          : @.puertoSelected
      instructor      : @.instructorSelected
      curso           : @.cursoSelected
      statusCurso     : "NUEVO"

    @.get('store').commit()

App.CursoProgramadoController = Ember.ObjectController.extend
  agregar : ->
    alumno = App.Alumno.createRecord
      nombreCompleto : @.get('nombreCompleto')
      observaciones : @.get('observaciones')

    @.get('alumnos').pushObject( alumno )


App.CursosProgramadosNuevoRoute = Ember.Route.extend
  setupController: (controller, model) ->
    controller.set('instructores', App.Instructor.find())
    controller.set('puertos', App.Puerto.find())
    controller.set('cursos', App.Curso.find())

App.Store = DS.Store.extend
  revision: 13,
  adapter: DS.RESTAdapter.reopen
    namespace: "siyen"

App.CursoProgramado = DS.Model.extend
  fechaDeInicio : DS.attr('string')
  fechaDeTermino : DS.attr('string')

  puerto: DS.belongsTo('App.Puerto')
  curso : DS.belongsTo('App.Curso')
  instructor : DS.belongsTo('App.Instructor')

  statusCurso : DS.attr('string')

  alumnos : DS.hasMany('App.Alumno')

App.Puerto = DS.Model.extend
  clave : DS.attr('string')
  puerto : DS.attr('string')

App.Curso = DS.Model.extend
  clave : DS.attr('string')
  nombre : DS.attr('string')
  duracion : DS.attr('number')

App.Instructor = DS.Model.extend
  nombre : DS.attr('string')
  numeroDeOficio : DS.attr('string')

App.StatusCurso = DS.Model.extend
  name : DS.attr('string')

App.Alumno = DS.Model.extend
  nombreCompleto : DS.attr('string')
  observaciones : DS.attr('string')


DS.RESTAdapter.map 'App.CursoProgramado',
  fechaDeInicio: { key: 'fechaDeInicio' }
  fechaDeTermino: { key: 'fechaDeTermino' }
  dateCreated: { key: 'dateCreated' }

  puerto : { key: 'puerto' }
  curso : { key : 'curso' }
  instructor : { key : 'instructor' }

  statusCurso: { key: 'statusCurso' }

Ember.Handlebars.registerBoundHelper 'date', (date) ->
  moment(date).format('DD/MMMM/YYYY')

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




