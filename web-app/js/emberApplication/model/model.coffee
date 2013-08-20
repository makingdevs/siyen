App.CursoProgramado = DS.Model.extend
  fechaDeInicio : DS.attr('string')
  fechaDeTermino : DS.attr('string')

  puerto: DS.belongsTo('App.Puerto')
  curso : DS.belongsTo('App.Curso')
  instructor : DS.belongsTo('App.Instructor')

  statusCurso : DS.attr('string')

  alumnos : DS.hasMany('App.Alumno')

App.Puerto = DS.Model.extend
  clave : DS.attr('string')
  puerto : DS.attr('string')

App.Curso = DS.Model.extend
  clave : DS.attr('string')
  nombre : DS.attr('string')
  duracion : DS.attr('number')

App.Instructor = DS.Model.extend
  nombre : DS.attr('string')
  numeroDeOficio : DS.attr('string')

App.StatusCurso = DS.Model.extend
  name : DS.attr('string')

App.Alumno = DS.Model.extend
  nombreCompleto : DS.attr('string')
  observaciones : DS.attr('string')