App.Router.map ->
  @route 'archivo'
  @route 'notificacion'
  @route 'busqueda'
  @route 'oficios'
  @route 'movimientos'

  @resource 'cursosNuevos', ->
    @resource 'crear', ->
      @route 'participantes'

  @resource 'alumnos', ->
    @resource 'alumno', { path : ":alumno_id" }

  @resource 'cursosAutorizados', ->
    @resource 'edit', { path: ":curso_programado_id" }

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
    controller.set 'disabled', false

    if( moment().diff(moment(fechaDeInicio, 'DD/MMMM/YYYY'), 'days') > 15 or model.get('alumnosRestantes') <= 0 )
      controller.set 'disabled', true

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

App.MovimientosRoute = Ember.Route.extend
  model : ->
    @get('store').find('cursoProgramado')

App.OficiosRoute = Ember.Route.extend
  setupController : (controller, model) ->
    @_super(controller, model)
    controller.set('instructores', @get('store').find('instructor'))
    controller.set('puertos', @get('store').find('puerto'))
