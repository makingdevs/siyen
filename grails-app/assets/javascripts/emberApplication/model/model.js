$(function() {
  App.Notificacion = DS.Model.extend({
    url: "/notificaciones/",
    inconmingId: DS.attr('string'),
    fechaDeAutorizacion: DS.attr('string'),
    fechaDeInicio: DS.attr('string'),
    puerto: DS.attr('string'),
    curso: DS.attr('string'),
    instructor: DS.attr('string'),
    alumnos: DS.attr('string'),
    accion: DS.attr('string'),
    creadoPor: DS.attr('string')
  });

  App.CursoProgramado = DS.Model.extend({
    fechaDeInicio: DS.attr('string'),
    fechaDeTermino: DS.attr('string'),
    alumnosRestantes: DS.attr('number'),
    puerto: DS.belongsTo('puerto'),
    curso: DS.belongsTo('curso'),
    instructor: DS.belongsTo('instructor'),
    alumnos: DS.hasMany('alumno'),
    descripcion: (function() {
      return "" + (this.get('id')) + " - " + (this.get('puerto.clave')) + " - " + (this.get('curso.clave')) + " - " + (moment(this.get('fechaDeInicio')).format('DD/MMMM/YYYY'));
    }).property('id', 'puerto', 'curso', 'fechaDeInicio'),
    currentDragItem: (function() {
      return this.get('alumnos').findBy("isDragging", true);
    }).property("alumnos.@each.isDragging"),
    currentInfoLabel: (function() {
      return this.get('alumnos').findBy("infoLabel", 'info');
    }).property("alumnos.@each.infoLabel")
  });

  App.Puerto = DS.Model.extend({
    clave: DS.attr('string'),
    puerto: DS.attr('string'),
    estado: DS.attr('string'),
    descripcion: (function() {
      return this.get('puerto') + ', ' + this.get('estado');
    }).property('puerto', 'estado')
  });

  App.Curso = DS.Model.extend({
    clave: DS.attr('string'),
    nombre: DS.attr('string'),
    duracion: DS.attr('number')
  });

  App.Instructor = DS.Model.extend({
    nombre: DS.attr('string'),
    numeroDeOficio: DS.attr('string')
  });

  App.Alumno = DS.Model.extend({
    numeroDeControl: DS.attr('string'),
    nombreCompleto: DS.attr('string'),
    observaciones: DS.attr('string'),
    monto: DS.attr('number',{defaultValue: 0}),
    tipoDePago: DS.attr('string'),
    cursoProgramado: DS.belongsTo('cursoProgramado'),
    descripcion: (function() {
      return "" + (this.get('numeroDeControl')) + " - " + (this.get('nombreCompleto'));
    }).property('numeroDeControl', 'nombreCompleto'),
    isDragging: false,
    droppingTarget: null,
    infoLabel: ''
  });

});
