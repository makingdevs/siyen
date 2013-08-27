// Generated by CoffeeScript 1.6.3
(function() {
  App.CursosNuevosController = Ember.ArrayController.extend({
    content: [],
    currentCurso: null,
    currentCursoObserves: (function() {
      if (this.currentCurso) {
        return this.transitionToRoute('crear.participantes');
      }
    }).observes('currentCurso'),
    autorizar: function(currentCurso) {
      var alumno, cursoProgramado, _i, _len, _ref, _results;
      cursoProgramado = App.CursoProgramado.createRecord({
        fechaDeInicio: currentCurso.get('fechaDeInicio').format('DD/MMMM/YYYY'),
        puertoSelected: currentCurso.get('puerto'),
        instructorSelected: currentCurso.get('instructor'),
        cursoSelected: currentCurso.get('curso')
      });
      _ref = currentCurso.get('alumnos');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        alumno = _ref[_i];
        _results.push(cursoProgramado.get('alumnos').pushObject(App.Alumno.createRecord({
          nombreCompleto: alumno.get('nombreCompleto'),
          observaciones: alumno.get('observaciones')
        })));
      }
      return _results;
    }
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
    currentCursoObserves: (function() {
      var currentCurso, cursosNuevosController;
      cursosNuevosController = this.get('controllers.cursosNuevos');
      currentCurso = cursosNuevosController.get('currentCurso');
      if (currentCurso) {
        this.set("fechaDeInicio", currentCurso.get('fechaDeInicio').format('DD/MMMM/YYYY'));
        this.set("puertoSelected", currentCurso.get('puerto'));
        this.set("instructorSelected", currentCurso.get('instructor'));
        return this.set("cursoSelected", currentCurso.get('curso'));
      }
    }).observes('controllers.cursosNuevos.currentCurso'),
    init: function() {
      this._super();
      this.set('instructores', App.Instructor.find());
      this.set('puertos', App.Puerto.find());
      return this.set('cursos', App.Curso.find());
    },
    crear: function() {
      var content, cursoProgramado, cursosNuevosController, _ref;
      cursosNuevosController = this.get('controllers.cursosNuevos');
      content = cursosNuevosController.get('content');
      cursoProgramado = Ember.Object.create({
        "fechaDeInicio": moment((_ref = this.fechaDeInicio) != null ? _ref : moment(), 'DD/MMMM/YYYY'),
        "puerto": this.get('puertoSelected'),
        "instructor": this.get('instructorSelected'),
        "curso": this.get('cursoSelected'),
        "alumnos": []
      });
      content.pushObject(cursoProgramado);
      return cursosNuevosController.set('currentCurso', cursoProgramado);
    },
    finalizar: function() {
      var cursosNuevosController;
      cursosNuevosController = this.get('controllers.cursosNuevos');
      cursosNuevosController.set('currentCurso', null);
      this.set("fechaDeInicio", moment().format('DD/MMMM/YYYY'));
      this.set("puertoSelected", null);
      this.set("instructorSelected", null);
      this.set("cursoSelected", null);
      return this.transitionToRoute('cursosNuevos.index');
    }
  });

  App.CrearParticipantesController = Ember.ObjectController.extend({
    needs: "cursosNuevos",
    nombreCompleto: null,
    observaciones: null,
    currentCursoObserves: (function() {
      var currentCurso, cursosNuevosController;
      cursosNuevosController = this.get('controllers.cursosNuevos');
      currentCurso = cursosNuevosController.get('currentCurso');
      if (currentCurso) {
        this.set("nombreCompleto", null);
        return this.set("observaciones", null);
      }
    }).observes('controllers.cursosNuevos.currentCurso'),
    agregar: function() {
      var currentCurso;
      currentCurso = this.get('controllers.cursosNuevos').get('currentCurso');
      currentCurso.get('alumnos').pushObject(Ember.Object.create({
        nombreCompleto: this.nombreCompleto,
        observaciones: this.observaciones
      }));
      this.set("nombreCompleto", null);
      return this.set("observaciones", null);
    }
  });

  App.ArchivoController = Ember.ObjectController.extend({
    participantes: [],
    procesarArchivo: function() {
      var dropzone,
        _this = this;
      dropzone = Dropzone.forElement("div#dropzone.dropzone");
      dropzone.processQueue();
      return dropzone.on("success", function(file, response) {
        var fila, _i, _len, _ref, _results;
        file.previewElement.classList.add("dz-success");
        _ref = response.contenidoDeFilas;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          fila = _ref[_i];
          _results.push(_this.participantes.pushObject(Ember.Object.create({
            nombreCompleto: fila.get(1),
            observaciones: fila.get(2)
          })));
        }
        return _results;
      });
    }
  });

}).call(this);
