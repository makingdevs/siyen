window.App = Ember.Application.create()

App.Router.map -> 
  @.resource 'cursosNuevos', ->
    @.route 'crear'
    @.route 'participantes'

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

    cursoProgramado = App.CursoProgramado.createRecord
      fechaDeInicio   : fechaDeInicio
      puerto          : @.puertoSelected
      instructor      : @.instructorSelected
      curso           : @.cursoSelected

    cursosNuevosController = @.get('controllers.cursosNuevos')
    cursosNuevosController.get('content').pushObject(cursoProgramado)

    @.set 'puertoSelected', null
    @.set 'instructorSelected', null
    @.set 'cursoSelected', null

    @.transitionToRoute('cursosNuevos.participantes')


DS.RESTAdapter.configure "plurals",
  instructor: "instructores",

DS.RESTAdapter.map 'App.CursoProgramado',
  fechaDeInicio: { key: 'fechaDeInicio' }
  fechaDeTermino: { key: 'fechaDeTermino' }
  dateCreated: { key: 'dateCreated' }

  puerto : { key: 'puerto' }
  curso : { key : 'curso' }
  instructor : { key : 'instructor' }

  statusCurso: { key: 'statusCurso' }

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




