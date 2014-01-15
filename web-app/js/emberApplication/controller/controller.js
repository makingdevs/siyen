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
          fechaDeInicio: cursoProgramadoTemp.get('fechaDeInicio').format('DD/MM/YYYY'),
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

  App.EditController = Ember.ObjectController.extend({
    cursos: [],
    fechaDeInicio: null,
    nombreCompleto: null,
    observaciones: null,
    currentParticipanteIndex: -1,
    init: function() {
      this._super();
      return this.set('cursos', this.get('store').find("curso"));
    },
    actions: {
      actualizarCurso: function() {
        var cursoProgramado;
        cursoProgramado = this.get('model');
        return cursoProgramado.save();
      },
      actualizar: function() {
        var alumno, cursoProgramado;
        cursoProgramado = this.get('model');
        if (this.currentParticipanteIndex >= 0) {
          alumno = cursoProgramado.get('alumnos').objectAt(this.currentParticipanteIndex);
        } else {
          alumno = this.store.createRecord('alumno');
        }
        alumno.set('nombreCompleto', this.nombreCompleto);
        alumno.set('observaciones', this.observaciones);
        alumno.set('cursoProgramado', cursoProgramado);
        alumno.save();
        this.set('currentParticipanteIndex', -1);
        this.set("nombreCompleto", null);
        return this.set("observaciones", null);
      }
    }
  });

  App.EditParticipantesController = Ember.ObjectController.extend();

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
        console.log(cursoProgramado);
        return this.transitionToRoute('cursosNuevos.index');
      }
    }
  });

  App.NotificacionController = Ember.ArrayController.extend({
    content: [],
    init: function() {
      var crearNotificacionConRespuesta, eventBus,
        _this = this;
      this._super();
      eventBus = new vertx.EventBus('http://localhost:9091/eventbus');
      eventBus.onopen = function() {
        console.log("Event Bus connected");
        eventBus.registerHandler('cursoProgramado.autorizado', function(jsonMessage) {
          return crearNotificacionConRespuesta(jsonMessage);
        });
        eventBus.registerHandler('cursoProgramado.impresion', function(jsonMessage) {
          return crearNotificacionConRespuesta(jsonMessage);
        });
        eventBus.registerHandler('cursoProgramado.actualizado', function(jsonMessage) {
          return crearNotificacionConRespuesta(jsonMessage);
        });
        eventBus.registerHandler('cursoProgramado.alumno_add', function(jsonMessage) {
          return crearNotificacionConRespuesta(jsonMessage);
        });
        return eventBus.registerHandler('cursoProgramado.alumno_edit', function(jsonMessage) {
          return crearNotificacionConRespuesta(jsonMessage);
        });
      };
      return crearNotificacionConRespuesta = function(jsonMessage) {
        var notificacion;
        notificacion = Ember.Object.create({
          id: jsonMessage.id,
          fechaDeAutorizacion: jsonMessage.fechaDeAutorizacion,
          fechaDeInicio: jsonMessage.fechaDeInicio,
          puerto: jsonMessage.puerto,
          curso: jsonMessage.curso,
          instructor: jsonMessage.instructor,
          alumnos: jsonMessage.alumnos,
          creadoPor: jsonMessage.creadoPor,
          accion: jsonMessage.accion
        });
        return _this.content.pushObject(notificacion);
      };
    }
  });

  App.BusquedaController = Ember.ObjectController.extend({
    busqueda: null,
    urlBusqueda: null,
    desde: null,
    hasta: null,
    init: function() {
      this.set('urlBusqueda', $("#urlBusqueda").val());
      return $("body").on("click", ".pagination li a", function(event) {
        event.preventDefault();
        return $.ajax({
          type: "GET",
          url: event.target,
          success: function(res, status, xhr) {
            $("#resultados").html(res);
            return $("#busquedaAvanzada").hide();
          },
          error: function(xhr, status, err) {
            return console.log("error");
          }
        });
      });
    },
    actions: {
      realizarBusqueda: function() {
        var busqueda, cursos, desde, hasta, instructores, puertos, _ref, _ref1, _ref2;
        busqueda = this.get('busqueda');
        cursos = (_ref = $("#cursos").val()) != null ? _ref.toString() : void 0;
        puertos = (_ref1 = $("#puertos").val()) != null ? _ref1.toString() : void 0;
        instructores = (_ref2 = $("#instructores").val()) != null ? _ref2.toString() : void 0;
        if (this.get('desde') && this.get('hasta')) {
          desde = moment(this.get('desde'), "DD/MMM/YYYY").format('DD/MM/YYYY');
          hasta = moment(this.get('hasta'), "DD/MMM/YYYY").format('DD/MM/YYYY');
        }
        return $.ajax({
          type: "POST",
          url: this.get('urlBusqueda'),
          data: {
            buscar: busqueda,
            cursos: cursos,
            puertos: puertos,
            instructores: instructores,
            desde: desde,
            hasta: hasta
          },
          success: function(res, status, xhr) {
            $("#resultados").html(res);
            return $("#busquedaAvanzada").hide();
          },
          error: function(xhr, status, err) {
            return console.log("error");
          }
        });
      }
    }
  });

}).call(this);
