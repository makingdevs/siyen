App.Router.map ->
  @route 'archivo'
  @route 'notificacion'
  @route 'busqueda'

  @resource 'cursosNuevos', ->
    @resource 'crear', ->
      @route 'participantes'

  @resource 'cursosAutorizados', ->
    @resource 'edit', { path: ":curso_programado_id" }

App.CursosNuevosRoute = Ember.Route.extend()
App.CrearRoute = Ember.Route.extend()
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
      cursos = $("#cursos")
      for value in data.cursos
        $("<option value='#{value}'>#{value}</option>").appendTo(cursos)

      puertos = $("#puertos")
      for value in data.puertos
        $("<option value='#{value}'>#{value}</option>").appendTo(puertos)

      instructores = $("#instructores")
      for value in data.instructores
        $("<option value='#{value.nombre}'>#{value.nombre}</option>").appendTo(instructores)

      $(".busquedaChosen").trigger("chosen:updated")
    )
