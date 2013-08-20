App.Router.map -> 
  @.resource 'cursosNuevos', ->
    @.route 'crear'
    @.resource 'participante', { path : ":curso_programado" }