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
  puertoSelected : null
  instructorSelected : null
  cursoSelected : null
  fechaDeInicio : null

  guardar : ->
    console.log "guardando"
    console.log "fechaDeInicio : #{@.fechaDeInicio ? moment().format('DD/MMMM/YYYY')}"
    console.log "puerto seleccionado : #{@.puertoSelected}"
    console.log "puerto seleccionado : #{@.instructorSelected}"
    console.log "puerto seleccionado : #{@.cursoSelected}"


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
  moment(date).format('DD/MMMM/YYYY')

App.DatePickerView = Ember.View.extend
  template: Ember.Handlebars.compile(
    '<div class="input-append date" id="datepicker" >' +
      '<input size="16" type="text" readonly>' +
      '<span class="add-on"><i class="icon-th"></i></span>' +
    '</div>'
    )

  didInsertElement: ->
    onChangeDate = (ev) =>
      @.set "value", moment.utc(ev.date).format("DD/MM/YYYY")

    ($ '#datepicker').datepicker(
      format          : "dd/MM/yyyy"
      autoclose       : true
      todayHighlight  : true
      language        : 'es'
      startDate       : '1d'
      ).on "changeDate", onChangeDate

    ($ "#datepicker > input").val(moment().format('DD/MMMM/YYYY'))




