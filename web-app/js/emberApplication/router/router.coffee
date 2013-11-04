App.Router.map -> 
  @resource 'cursosNuevos', ->
    @resource 'crear', ->
      @route 'participantes'

  @resource 'archivo'

  @resource 'cursosAutorizados', ->
    @resource 'edit', { path: ":curso_programado_id" }

  @resource 'notificacion'

  @resource 'busqueda'

App.CursosNuevosRoute = Ember.Route.extend()
App.CursosNuevosCrearRoute = Ember.Route.extend()
App.CrearParticipantesRoute = Ember.Route.extend()

App.ArchivoRoute = Ember.Route.extend()

App.NotificacionRoute = Ember.Route.extend()

App.CursosAutorizadosRoute = Ember.Route.extend
  model : ->
    @get('store').find('cursoProgramado')

App.EditRoute = Ember.Route.extend
  setupController : (controller, model) ->
    fechaDeInicioModel = model.get('fechaDeInicio')
    fechaDeInicio = moment(fechaDeInicioModel).format('DD/MMMM/YYYY')
    controller.set('fechaDeInicio', fechaDeInicio)
    controller.set('model', model)

  model : (params) ->
    @get('store').find('cursoProgramado', params.curso_programado_id)

App.BusquedaRoute = Ember.Route.extend
  setupController : (controller, model) ->
    @_super(controller, model)

    $.getJSON( "catalogo/obtenerDatosDeBusqueda", ( data ) ->
      busquedaChosen = $("#busquedaChosen")

      for value in data.cursos
        $("<option value='#{value}'>#{value}</option>").appendTo(busquedaChosen)

      for value in data.puertos
        $("<option value='#{value}'>#{value}</option>").appendTo(busquedaChosen)

      for value in data.instructores
        $("<option value='#{value.id}'>#{value.nombre}</option>").appendTo(busquedaChosen)

      busquedaChosen.trigger("chosen:updated")
    )