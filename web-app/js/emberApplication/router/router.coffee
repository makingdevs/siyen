App.Router.map -> 
  @.resource 'cursosNuevos', ->
    @.resource 'crear', ->
      @.route 'participantes'

  @.resource 'archivo'

App.CursosNuevosRoute = Ember.Route.extend()
App.CursosNuevosCrearRoute = Ember.Route.extend()
App.CrearParticipantesRoute = Ember.Route.extend()

App.ArchivoRoute = Ember.Route.extend()