// Generated by CoffeeScript 1.6.3
(function() {
  App.CursosNuevosController = Ember.ArrayController.extend({
    content: []
  });

  App.CurrentCursoNuevoController = Ember.ObjectController.extend({
    needs: "cursosNuevos",
    contentBinding: 'cursosNuevosController.cursoNuevo',
    cursosNuevosController: null
  });

  App.CursosNuevosCrearController = Ember.ObjectController.extend();

  App.CrearController = Ember.ObjectController.extend({
    needs: ["cursosNuevos"],
    instructores: [],
    puertos: [],
    cursos: [],
    fechaDeInicio: null,
    puertoSelected: null,
    instructorSelected: null,
    cursoSelected: null,
    init: function() {
      this._super();
      this.set('instructores', App.Instructor.find());
      this.set('puertos', App.Puerto.find());
      return this.set('cursos', App.Curso.find());
    },
    crear: function() {
      var content, cursosNuevosController, _ref;
      cursosNuevosController = this.get('controllers.cursosNuevos');
      content = cursosNuevosController.get('content');
      return content.pushObject(Ember.Object.create({
        "fechaDeInicio": moment((_ref = this.fechaDeInicio) != null ? _ref : moment(), 'DD/MMMM/YYYY'),
        "puerto": this.get('puertoSelected'),
        "instructor": this.get('instructorSelected'),
        "curso": this.get('cursoSelected'),
        "alumnos": [],
        "currentCurso": true
      }));
    }
  });

}).call(this);
