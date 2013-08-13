window.App = Ember.Application.create()

App.Router.map -> 
  @.resource 'cursosProgramados', ->
    @.route 'nuevo'

App.CursosProgramadosRoute = Ember.Route.extend
  model: ->
    App.CursoProgramado.find()


App.CursosProgramadosNuevoController = Ember.ObjectController.extend
  instructores: []
  puertos : []
  cursos : []

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
  fechaDeInicio : DS.attr('date')
  fechaDeTermino : DS.attr('date')
  dateCreated : DS.attr('date')

  puerto: DS.belongsTo('App.Puerto')
  curso : DS.belongsTo('App.Curso')
  instructor : DS.belongsTo('App.Instructor')

  statusCurso : DS.attr('string')

App.Puerto = DS.Model.extend
  clave : DS.attr('string')
  puerto : DS.attr('string')

App.Curso = DS.Model.extend
  clave : DS.attr('string')
  nombre : DS.attr('string')

App.Instructor = DS.Model.extend
  nombre : DS.attr('string')
  numeroDeOficio : DS.attr('string')

App.StatusCurso = DS.Model.extend
  name : DS.attr('string')


DS.RESTAdapter.map 'App.CursoProgramado',
  fechaDeInicio: { key: 'fechaDeInicio' }
  fechaDeTermino: { key: 'fechaDeTermino' }
  dateCreated: { key: 'dateCreated' }

  puerto : { key: 'puerto' }
  curso : { key : 'curso' }
  instructor : { key : 'instructor' }

  statusCurso: { key: 'statusCurso' }


Ember.Handlebars.registerBoundHelper 'date', (date) ->
  moment().format('DD/MMMM/YYYY')







