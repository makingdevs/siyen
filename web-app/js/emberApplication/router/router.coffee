App.Router.map -> 
  @resource 'cursosNuevos', ->
    @resource 'crear', ->
      @route 'participantes'

  @resource 'archivo'

  @resource 'cursosAutorizados', ->
    @route 'edit', { path: ":curso_programado_id" }

App.CursosNuevosRoute = Ember.Route.extend()
App.CursosNuevosCrearRoute = Ember.Route.extend()
App.CrearParticipantesRoute = Ember.Route.extend()

App.ArchivoRoute = Ember.Route.extend()

App.CursosAutorizadosRoute = Ember.Route.extend
  model : ->
    @get('store').find('cursoProgramado')

App.CursosAutorizadosEditRoute = Ember.Route.extend
  model : (params) ->
    @get('store').find('cursoProgramado', params.curso_programado_id)
