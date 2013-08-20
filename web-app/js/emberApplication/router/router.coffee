App.Router.map -> 
  @.resource 'cursosNuevos', ->
    @.resource 'crear', ->
      @.route 'participantes'

App.CursosNuevosRoute = Ember.Route.extend()