App.CursoProgramado = DS.Model.extend
  fechaDeInicio : DS.attr('string')
  fechaDeTermino : DS.attr('string')
  alumnosRestantes : DS.attr('number')

  puerto: DS.belongsTo('puerto')
  curso : DS.belongsTo('curso')
  instructor : DS.belongsTo('instructor')

  alumnos : DS.hasMany('alumno')

  descripcion : (->
    "#{@get('id')} - #{@get('puerto.clave')} - #{@get('curso.clave')} - #{moment(@get('fechadeinicio')).format('DD/MMMM/YYYY')}"
  ).property('id', 'puerto', 'curso', 'fechadeinicio')

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

  cursoProgramado : DS.belongsTo('cursoProgramado')

  descripcion : (->
    "#{@get('numeroDeControl')} - #{@get('nombreCompleto')}"
  ).property('numeroDeControl', 'nombreCompleto')
