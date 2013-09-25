App.Router.map -> 
  @resource 'cursosNuevos', ->
    @resource 'crear', ->
      @route 'participantes'

  @resource 'archivo'

  @resource 'cursosAutorizados', ->
    @resource 'edit', { path: ":curso_programado_id" }, ->
      @route 'participantes'

App.CursosNuevosRoute = Ember.Route.extend()
App.CursosNuevosCrearRoute = Ember.Route.extend()
App.CrearParticipantesRoute = Ember.Route.extend()

App.ArchivoRoute = Ember.Route.extend()

App.CursosAutorizadosRoute = Ember.Route.extend
  model : ->
    @get('store').find('cursoProgramado')

App.CursosAutorizadosEditRoute = Ember.Route.extend
  setupController : (controller, model) ->
    fechaDeInicioModel = model.get('fechaDeInicio')
    fechaDeInicio = moment(fechaDeInicioModel).format('DD/MMMM/YYYY')
    controller.set('fechaDeInicio', fechaDeInicio)
    controller.set('model', model)

  model : (params) ->
    @get('store').find('cursoProgramado', params.curso_programado_id)

App.EditParticipantesRoute = Ember.Route.extend()