App.Router.map -> 
  @.resource 'cursosNuevos', ->
    @.resource 'crear', ->
      @.route 'participantes'

  @.resource 'archivo'

  @resource 'cursosAutorizados'

App.CursosNuevosRoute = Ember.Route.extend()
App.CursosNuevosCrearRoute = Ember.Route.extend()
App.CrearParticipantesRoute = Ember.Route.extend()

App.ArchivoRoute = Ember.Route.extend()

App.CursosAutorizadosRoute = Ember.Route.extend
  model: ->
    App.CursoProgramado.find()