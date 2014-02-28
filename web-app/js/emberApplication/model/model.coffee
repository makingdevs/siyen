App.CursoProgramado = DS.Model.extend
  fechaDeInicio : DS.attr('string')
  fechaDeTermino : DS.attr('string')
  alumnosRestantes : DS.attr('number')

  puerto: DS.belongsTo('puerto')
  curso : DS.belongsTo('curso')
  instructor : DS.belongsTo('instructor')

  alumnos : DS.hasMany('alumno')

  descripcion : (->
    "#{@get('id')} - #{@get('puerto.clave')} - #{@get('curso.clave')} - #{moment(@get('fechaDeInicio')).format('DD/MMMM/YYYY')}"
  ).property('id', 'puerto', 'curso', 'fechaDeInicio')

  currentDragItem: ( ->
    @get('alumnos').findBy("isDragging", true)
  ).property("alumnos.@each.isDragging")

  currentInfoLabel: ( ->
    @get('alumnos').findBy("infoLabel", 'info')
  ).property("alumnos.@each.infoLabel")

App.Puerto = DS.Model.extend
  clave : DS.attr('string')
  puerto : DS.attr('string')
  estado : DS.attr('string')

  descripcion: ( ->
    @.get('puerto') + ', ' + @.get('estado')
  ).property('puerto', 'estado')

App.Curso = DS.Model.extend
  clave : DS.attr('string')
  nombre : DS.attr('string')
  duracion : DS.attr('number')

App.Instructor = DS.Model.extend
  nombre : DS.attr('string')
  numeroDeOficio : DS.attr('string')

App.Alumno = DS.Model.extend
  numeroDeControl : DS.attr('string')
  nombreCompleto : DS.attr('string')
  observaciones : DS.attr('string')
  monto : DS.attr('number')
  tipoDePago : DS.attr('string')

  cursoProgramado : DS.belongsTo('cursoProgramado')
  descripcion : (->
    "#{@get('numeroDeControl')} - #{@get('nombreCompleto')}"
  ).property('numeroDeControl', 'nombreCompleto')

  isDragging : false
  droppingTarget : null
  infoLabel : ''
