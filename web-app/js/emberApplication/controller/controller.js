// Generated by CoffeeScript 1.6.3
(function() {
  App.CursosNuevosController = Ember.ArrayController.extend({
    content: [],
    currentCurso: null,
    autorizarCurso: null,
    currentCursoObserves: (function() {
      if (this.currentCurso) {
        return this.transitionToRoute('crear.participantes');
      }
    }).observes('currentCurso'),
    autorizar: function() {
      return ($("#confirmarAutorizacionDialog")).modal({
        show: true
      });
    },
    actions: {
      doCancelAutorizacion: function() {
        ($("#confirmarAutorizacionDialog")).modal('hide');
        return this.set('autorizarCurso', null);
      },
      doRealizarAutorizacion: function() {
        var alumno, cursoProgramado, cursoProgramadoLocal, cursoProgramadoTemp, _i, _len, _ref,
          _this = this;
        cursoProgramadoTemp = this.get('autorizarCurso');
        cursoProgramadoLocal = {
          fechaDeInicio: cursoProgramadoTemp.get('fechaDeInicio').format('DD/MMMM/YYYY'),
          puerto: cursoProgramadoTemp.get('puerto'),
          instructor: cursoProgramadoTemp.get('instructor'),
          curso: cursoProgramadoTemp.get('curso')
        };
        cursoProgramado = this.store.createRecord('cursoProgramado', cursoProgramadoLocal);
        _ref = cursoProgramadoTemp.get('alumnos');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          alumno = _ref[_i];
          cursoProgramado.get('alumnos').createRecord({
            nombreCompleto: alumno.get('nombreCompleto'),
            observaciones: alumno.get('observaciones')
          });
        }
        return cursoProgramado.save().then(function(value) {
          ($("#confirmarAutorizacionDialog")).modal('hide');
          _this.content.removeObject(_this.get('autorizarCurso'));
          return _this.transitionToRoute('cursosAutorizados');
        }, function() {
          return console.log("failed");
        });
      }
    }
  });

  App.CursosAutorizadosController = Ember.ArrayController.extend();

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
      this.set('instructores', this.get('store').find("instructor"));
      this.set('puertos', this.get('store').find("puerto"));
      return this.set('cursos', this.get('store').find("curso"));
    },
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
    actions: {
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
    }
  });

  App.CrearParticipantesController = Ember.ObjectController.extend({
    needs: "cursosNuevos",
    nombreCompleto: null,
    observaciones: null,
    currentParticipanteIndex: -1,
    currentCursoObserves: (function() {
      var currentCurso, cursosNuevosController;
      cursosNuevosController = this.get('controllers.cursosNuevos');
      currentCurso = cursosNuevosController.get('currentCurso');
      if (currentCurso) {
        this.set("nombreCompleto", null);
        return this.set("observaciones", null);
      }
    }).observes('controllers.cursosNuevos.currentCurso'),
    actions: {
      agregar: function() {
        var alumno, currentCurso;
        currentCurso = this.get('controllers.cursosNuevos').get('currentCurso');
        alumno = Ember.Object.create({
          nombreCompleto: this.nombreCompleto,
          observaciones: this.observaciones
        });
        if (this.currentParticipanteIndex >= 0) {
          currentCurso.get('alumnos').replace(this.currentParticipanteIndex, 1, [alumno]);
        } else {
          currentCurso.get('alumnos').pushObject(alumno);
        }
        this.set('currentParticipanteIndex', -1);
        this.set("nombreCompleto", null);
        return this.set("observaciones", null);
      }
    }
  });

  App.ArchivoController = Ember.ObjectController.extend({
    needs: ["cursosNuevos"],
    instructores: [],
    puertos: [],
    cursos: [],
    fechaDeInicio: null,
    puertoSelected: null,
    instructorSelected: null,
    cursoSelected: null,
    participantes: [],
    init: function() {
      this._super();
      this.set('instructores', this.get('store').find("instructor"));
      this.set('puertos', this.get('store').find("puerto"));
      return this.set('cursos', this.get('store').find("curso"));
    },
    actions: {
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
              observaciones: $.trim(fila.get(2))
            })));
          }
          return _results;
        });
      },
      finalizar: function() {
        var content, cursoProgramado, cursosNuevosController, _ref;
        cursosNuevosController = this.get('controllers.cursosNuevos');
        content = cursosNuevosController.get('content');
        cursoProgramado = Ember.Object.create({
          "fechaDeInicio": moment((_ref = this.fechaDeInicio) != null ? _ref : moment(), 'DD/MMMM/YYYY'),
          "puerto": this.get('puertoSelected'),
          "instructor": this.get('instructorSelected'),
          "curso": this.get('cursoSelected'),
          "alumnos": this.get('participantes')
        });
        content.pushObject(cursoProgramado);
        cursosNuevosController.set('currentCurso', null);
        return this.transitionToRoute('cursosNuevos.index');
      }
    }
  });

}).call(this);
