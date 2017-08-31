$(function() {
  App.BusquedaForGetType = Ember.Mixin.create({
    busquedaGetWithSelector: function(selector) {
      return $("body").on("click", selector, function(event) {
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
    }
  });

  App.CursosNuevosController = Ember.ArrayController.extend(App.BusquedaForGetType, {
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
        var alumno, cursoProgramado, cursoProgramadoLocal, cursoProgramadoTemp, _i, _len, _ref;
        ($("#primary")).attr('disabled', true);
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
            observaciones: alumno.get('observaciones'),
            tipoDePago: alumno.get('tipoDePago'),
            monto: alumno.get('monto')
          });
        }
        return cursoProgramado.save().then((function(_this) {
          return function(value) {
            ($("#primary")).attr('disabled', false);
            ($("#confirmarAutorizacionDialog")).modal('hide');
            _this.content.removeObject(_this.get('autorizarCurso'));
            return _this.transitionToRoute('cursosAutorizados');
          };
        })(this), (function(_this) {
          return function(reason) {
            var cursos, desde, hasta, instructores, jsonData, puertos;
            ($("#primary")).attr('disabled', false);
            cursoProgramado.rollback();
            ($("#confirmarAutorizacionDialog")).modal('hide');
            jsonData = eval('(' + reason.responseText + ')');
            cursos = "" + jsonData.curso + ",";
            puertos = "" + jsonData.puerto + ",";
            instructores = "" + jsonData.instructor + ",";
            desde = moment(jsonData.fechaDeInicio, "YYYY-MM-DD").format('DD/MM/YYYY');
            hasta = moment(jsonData.fechaDeTermino, "YYYY-MM-DD").format('DD/MM/YYYY');
            ($("#duplicacion > .modal-body")).html("<p> Se ha encontrado un curso con los mismos datos : </p>\n\n<dl class=\"dl-horizontal\">\n  <dt>Fecha de inicio</dt>\n  <dd>" + desde + "</dd>\n\n  <dt>Fecha de término</dt>\n  <dd>" + hasta + "</dd>\n\n  <dt>Instructor</dt>\n  <dd>" + (instructores.replace(',', '')) + "</dd>\n\n  <dt>Curso</dt>\n  <dd>" + (cursos.replace(',', '')) + "</dd>\n\n  <dt>Puerto</dt>\n  <dd>" + (puertos.replace(',', '')) + "</dd>\n</dl>");
            ($("#duplicacion > .modal-footer")).html("<a href=\"/busqueda/realizarBusqueda?buscar=&cursos=" + cursos + "&puertos=" + puertos + "&instructores=" + instructores + "&desde=" + desde + "&hasta=" + hasta + "&offset=0&max=10\" id=\"busqueda\" class=\"btn btn-primary\"> Ver los datos duplicados </a>");
            _this.busquedaGetWithSelector("#busqueda");
            $("body").on("click", "#busqueda", function(event) {
              $("#duplicacion").modal('hide');
              return _this.transitionToRoute('busqueda');
            });
            return ($("#duplicacion")).modal('show');
          };
        })(this));
      }
    }
  });

  App.CursosAutorizadosController = Ember.ArrayController.extend();

  App.EditController = Ember.ObjectController.extend({
    fechaDeInicio: null,
    fechaDeInicioFormatted: (function() {
      return moment(this.get('model.fechaDeInicio'), "YYYY-MM-DD").format('DD/MMMM/YYYY');
    }).property('fechaDeInicio'),
    nombreCompleto: null,
    observaciones: null,
    monto: null,
    tipoDePago: null,
    currentParticipanteIndex: -1,
    tiposDePagos: [
      {
        id: 'EFECTIVO',
        name: 'Efectivo'
      }, {
        id: 'BECADO',
        name: 'Becado'
      }, {
        id: 'DEPOSITO_BANCARIO',
        name: 'Depósito Bancario'
      }
    ],
    tipoDePagoSelected: null,
    actions: {
      actualizar: function() {
        var alumno, cursoProgramado;
        cursoProgramado = this.get('model');
        if (this.currentParticipanteIndex >= 0) {
          alumno = cursoProgramado.get('alumnos').objectAt(this.currentParticipanteIndex);
        } else {
          alumno = this.store.createRecord('alumno');
        }
        if (!this.tipoDePagoSelected) {
          ($("#error .message")).text('El tipo de pago es obligatorio');
          ($("#error")).fadeIn('slow', function() {
            return ($(this)).delay(3000).fadeOut('slow');
          });
          return;
        }
        switch (this.tipoDePagoSelected.id) {
          case "EFECTIVO":
          case "DEPOSITO_BANCARIO":
            if (this.monto <= 0) {
              ($("#error .message")).text('El campo de monto es obligatorio');
              ($("#error")).fadeIn('slow', function() {
                return ($(this)).delay(3000).fadeOut('slow');
              });
              return;
            }
            break;
          case 'BECADO':
            if (!this.observaciones) {
              ($("#error .message")).text('El campo de observaciones es obligatorio');
              ($("#error")).fadeIn('slow', function() {
                return ($(this)).delay(3000).fadeOut('slow');
              });
              return;
            }
        }
        alumno.set('nombreCompleto', this.nombreCompleto);
        alumno.set('tipoDePago', this.tipoDePagoSelected.id);
        alumno.set('observaciones', this.observaciones);
        alumno.set('monto', this.monto);
        alumno.set('cursoProgramado', cursoProgramado);
        alumno.save().then(function(success) {
          var _ref;
          if ((_ref = cursoProgramado.get('currentInfoLabel')) != null) {
            _ref.set('infoLabel', '');
          }
          success.set('infoLabel', 'info');
          return cursoProgramado.decrementProperty('alumnosRestantes');
        }, function(reason) {
          var jsonData;
          alumno.rollback();
          jsonData = eval('(' + reason.responseText + ')');
          ($("#alertas strong")).text('ERROR');
          ($("#alertas .message")).text(jsonData.message);
          ($("#alertas")).attr("class", "alert alert-error");
          return ($("#alertas")).fadeIn('slow', function() {
            return ($(this)).delay(5000).fadeOut('slow');
          });
        });
        return this.setProperties({
          currentParticipanteIndex: -1,
          tipoDePagoSelected: null,
          nombreCompleto: null,
          observaciones: null,
          monto: null
        });
      }
    }
  });

  App.EditParticipantesController = Ember.ObjectController.extend();

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
        var content, cursoProgramado, cursosNuevosController, _ref, _ref1;
        cursosNuevosController = this.get('controllers.cursosNuevos');
        content = cursosNuevosController.get('content');
        if (!this.get('puertoSelected')) {
          ($("#error .message")).text('El puerto es obligatorio');
          ($("#error")).fadeIn('slow', function() {
            return ($(this)).delay(3000).fadeOut('slow');
          });
          return;
        }
        if (!this.get('instructorSelected')) {
          ($("#error .message")).text('El instructor es obligatorio');
          ($("#error")).fadeIn('slow', function() {
            return ($(this)).delay(3000).fadeOut('slow');
          });
          return;
        }
        if (!this.get('cursoSelected')) {
          ($("#error .message")).text('El curso es obligatorio');
          ($("#error")).fadeIn('slow', function() {
            return ($(this)).delay(3000).fadeOut('slow');
          });
          return;
        }
        if (cursosNuevosController.get('currentCurso')) {
          cursoProgramado = cursosNuevosController.get('currentCurso');
          cursoProgramado.setProperties({
            "fechaDeInicio": moment((_ref = this.fechaDeInicio) != null ? _ref : moment(), 'DD/MMMM/YYYY'),
            "puerto": this.get('puertoSelected'),
            "instructor": this.get('instructorSelected'),
            "curso": this.get('cursoSelected')
          });
          return;
        }
        cursoProgramado = Ember.Object.create({
          "fechaDeInicio": moment((_ref1 = this.fechaDeInicio) != null ? _ref1 : moment(), 'DD/MMMM/YYYY'),
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
    monto: 0,
    tiposDePagos: [
      {
        id: 'EFECTIVO',
        name: 'Efectivo'
      }, {
        id: 'BECADO',
        name: 'Becado'
      }, {
        id: 'DEPOSITO_BANCARIO',
        name: 'Depósito Bancario'
      }
    ],
    tipoDePagoSelected: null,
    currentParticipanteIndex: -1,
    currentCursoObserves: (function() {
      var currentCurso, cursosNuevosController;
      cursosNuevosController = this.get('controllers.cursosNuevos');
      currentCurso = cursosNuevosController.get('currentCurso');
      if (currentCurso) {
        return this.setProperties({
          nombreCompleto: null,
          observaciones: null,
          tipoDePagoSelected: null,
          monto: null
        });
      }
    }).observes('controllers.cursosNuevos.currentCurso'),
    actions: {
      agregar: function() {
        var alumno, currentCurso;
        currentCurso = this.get('controllers.cursosNuevos').get('currentCurso');
        if (!this.tipoDePagoSelected) {
          ($("#error .message")).text('El tipo de pago es obligatorio');
          ($("#error")).fadeIn('slow', function() {
            return ($(this)).delay(3000).fadeOut('slow');
          });
          return;
        }
        alumno = Ember.Object.create({
          nombreCompleto: this.nombreCompleto,
          tipoDePago: this.tipoDePagoSelected.id,
          observaciones: this.observaciones,
          monto: this.monto,
          isNew: 'info'
        });
        switch (this.tipoDePagoSelected.id) {
          case "EFECTIVO":
          case "DEPOSITO_BANCARIO":
            if (this.monto <= 0) {
              ($("#error .message")).text('El campo de monto es obligatorio');
              ($("#error")).fadeIn('slow', function() {
                return ($(this)).delay(3000).fadeOut('slow');
              });
              return;
            }
            break;
          case 'BECADO':
            if (!this.observaciones) {
              ($("#error .message")).text('El campo de observaciones es obligatorio');
              ($("#error")).fadeIn('slow', function() {
                return ($(this)).delay(3000).fadeOut('slow');
              });
              return;
            }
        }
        if (currentCurso.get('alumnos').length) {
          var currentElementAdded = currentCurso.get('alumnos').findBy('isNew', 'info');
          if(currentElementAdded) {
            currentElementAdded.set('isNew', '');
          }
        }
        if (this.currentParticipanteIndex >= 0) {
          currentCurso.get('alumnos').replace(this.currentParticipanteIndex, 1, [alumno]);
        } else {
          currentCurso.get('alumnos').pushObject(alumno);
        }
        this.set('currentParticipanteIndex', -1);
        return this.setProperties({
          nombreCompleto: null,
          observaciones: null,
          tipoDePagoSelected: null,
          monto: null
        });
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
        var dropzone;
        dropzone = Dropzone.forElement("div#dropzone.dropzone");
        return dropzone.processQueue();
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
        this.send('limpiarProceso');
        return this.transitionToRoute('cursosNuevos.index');
      },
      limpiarProceso: function() {
        var dropzone;
        this.setProperties({
          fechaDeInicio: null,
          puertoSelected: null,
          instructorSelected: null,
          cursoSelected: null,
          participantes: []
        });
        dropzone = Dropzone.forElement("div#dropzone.dropzone");
        return dropzone.removeAllFiles(true);
      }
    }
  });

  App.NotificacionController = Ember.ArrayController.extend({
    content: [],
    init: function() {
      var crearNotificacionConRespuesta, eventBus, eventBusURL;
      this._super();
      eventBusURL = ($('#eventBusURL')).val();
      eventBus = new EventBus(eventBusURL);
      eventBus.onopen = function() {
        console.log("Event Bus connected");
        // eventBus.registerHandler('cursoProgramado.autorizado', function(jsonMessage) {
        //   return crearNotificacionConRespuesta(jsonMessage);
        // });
        // eventBus.registerHandler('cursoProgramado.impresion', function(jsonMessage) {
        //   return crearNotificacionConRespuesta(jsonMessage);
        // });
        // eventBus.registerHandler('cursoProgramado.impresion_de', function(jsonMessage) {
        //   return crearNotificacionConRespuesta(jsonMessage);
        // });
        // eventBus.registerHandler('cursoProgramado.actualizado', function(jsonMessage) {
        //   return crearNotificacionConRespuesta(jsonMessage);
        // });
        // eventBus.registerHandler('cursoProgramado.alumno_add', function(jsonMessage) {
        //   return crearNotificacionConRespuesta(jsonMessage);
        // });
        // return eventBus.registerHandler('cursoProgramado.alumno_edit', function(jsonMessage) {
        //   return crearNotificacionConRespuesta(jsonMessage);
        // });
      }
      return crearNotificacionConRespuesta = (function(_this) {
        return function(jsonMessage) {
          var notificacion;
          notificacion = _this.get('store').createRecord('notificacion', {
            inconmingId: jsonMessage.id,
            fechaDeAutorizacion: jsonMessage.fechaDeAutorizacion,
            fechaDeInicio: jsonMessage.fechaDeInicio,
            puerto: jsonMessage.puerto,
            curso: jsonMessage.curso,
            instructor: jsonMessage.instructor,
            alumnos: jsonMessage.alumnos,
            creadoPor: jsonMessage.creadoPor,
            accion: jsonMessage.accion
          });
          return notificacion.save();
        };
      })(this);
    }
  });

  App.BusquedaAlumnosController = Ember.ObjectController.extend(App.BusquedaForGetType, {
    busquedaDeAlumno: null,
    urlBusquedaDeAlumnos: null,
    init: function() {
      this.set('urlBusquedaDeAlumnos', $("#urlBusquedaDeAlumnos").val());
      return this.busquedaGetWithSelector('.pagination li a');
    },
    actions: {
      realizarBusqueda: function() {
        var busqueda;
        busqueda = this.get('busquedaDeAlumno');
        return $.ajax({
          type: "POST",
          url: this.get('urlBusquedaDeAlumnos'),
          data: {
            buscar: busqueda,
            edicion: true
          },
          success: function(res, status, xhr) {
            return $("#resultados").html(res);
          },
          error: function(xhr, status, err) {
            return console.log("error");
          }
        });
      }
    }
  });

  App.BusquedaController = Ember.ObjectController.extend(App.BusquedaForGetType, {
    busqueda: null,
    urlBusqueda: null,
    desde: null,
    hasta: null,
    init: function() {
      this.set('urlBusqueda', $("#urlBusqueda").val());
      return this.busquedaGetWithSelector('.pagination li a');
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

  App.AlumnosController = Ember.ObjectController.extend(App.BusquedaForGetType, {
    busquedaDeAlumno: null,
    urlBusquedaDeAlumnos: null,
    init: function() {
      this.set('urlBusquedaDeAlumnos', $("#urlBusquedaDeAlumnos").val());
      return this.busquedaGetWithSelector('.pagination li a');
    },
    actions: {
      realizarBusqueda: function() {
        var busqueda;
        busqueda = this.get('busquedaDeAlumno');
        return $.ajax({
          type: "POST",
          url: this.get('urlBusquedaDeAlumnos'),
          data: {
            buscar: busqueda
          },
          success: function(res, status, xhr) {
            return $("#resultados").html(res);
          },
          error: function(xhr, status, err) {
            return console.log("error");
          }
        });
      }
    }
  });

  App.MovimientosController = Ember.ObjectController.extend({
    actions: {
      doRealizarMovimiento: function() {
        var currentDragAlumno, cursoProgramadoOriginal;
        if (this.get('cursoSelectedA.currentDragItem')) {
          currentDragAlumno = this.get('cursoSelectedA.currentDragItem');
        }
        if (this.get('cursoSelectedB.currentDragItem')) {
          currentDragAlumno = this.get('cursoSelectedB.currentDragItem');
        }
        cursoProgramadoOriginal = currentDragAlumno.get('cursoProgramado');
        currentDragAlumno.set('cursoProgramado', currentDragAlumno.get('droppingTarget'));
        currentDragAlumno.save().then(function(success) {
          ($("#alertas strong")).text('ÉXITO');
          ($("#alertas .message")).text("El cambio se ha realizado satisfactoriamente.");
          ($("#alertas")).attr("class", "alert alert-success");
          return ($("#alertas")).fadeIn('slow', function() {
            return ($(this)).delay(3000).fadeOut('slow');
          });
        }, function(reason) {
          var jsonData;
          currentDragAlumno.set('cursoProgramado', cursoProgramadoOriginal);
          currentDragAlumno.rollback();
          jsonData = eval('(' + reason.responseText + ')');
          ($("#alertas strong")).text('ERROR');
          ($("#alertas .message")).text(jsonData.message);
          ($("#alertas")).attr("class", "alert alert-error");
          return ($("#alertas")).fadeIn('slow', function() {
            return ($(this)).delay(3000).fadeOut('slow');
          });
        });
        currentDragAlumno.setProperties({
          'isDragging': false
        }, 'droppingTarget', null);
        return ($("#confirmarMovimientoDialog")).modal('hide');
      },
      doCancelMovimiento: function() {
        return ($("#confirmarMovimientoDialog")).modal('hide');
      }
    }
  });

  App.OficiosController = Ember.ObjectController.extend({
    instructores: [],
    puertos: [],
    dirigidoA: null,
    puesto: null,
    puerto: null,
    deParteDe: null,
    desde: null,
    hasta: null
  });

  App.AlumnoController = Ember.ObjectController.extend(App.BusquedaForGetType, {
    cursos: [],
    needs: ['alumnos'],
    init: function() {
      this._super();
      return this.set('cursos', this.get('store').find("curso"));
    },
    actions: {
      realizarMovimiento: function() {
        return ($("#movimientoConfirmDialog")).modal({
          show: true
        });
      },
      doCancelarMovimiento: function() {
        return ($("#movimientoConfirmDialog")).modal('hide');
      },
      doConfirmarMovimiento: function() {
        var cursoProgramado;
        cursoProgramado = this.store.createRecord('cursoProgramado', {
          fechaDeInicio: moment(this.get('cursoProgramado.fechaDeInicio'), "YYYY-MM-DD").format('DD/MM/YYYY'),
          puerto: this.get('cursoProgramado.puerto'),
          curso: this.get('cursoProgramado.curso'),
          instructor: this.get('cursoProgramado.instructor')
        });
        cursoProgramado.get('alumnos').createRecord({
          numeroDeControl: this.get('numeroDeControl'),
          nombreCompleto: this.get('nombreCompleto'),
          observaciones: this.get('observaciones'),
          monto: this.get('monto')
        });
        cursoProgramado.save().then((function(_this) {
          return function(value) {
            var alumnosController;
            ($("#movimientoConfirmDialog")).modal('hide');
            ($("#alertas strong")).text('ÉXITO');
            ($("#alertas .message")).text("El cambio se ha realizado satisfactoriamente.");
            ($("#alertas")).attr("class", "alert alert-success");
            ($("#alertas")).fadeIn('slow', function() {
              return ($(this)).delay(5000).fadeOut('slow');
            });
            alumnosController = _this.get('controllers.alumnos');
            alumnosController.send('realizarBusqueda');
            return _this.transitionToRoute('alumnos');
          };
        })(this), (function(_this) {
          return function(reason) {
            var cursos, desde, hasta, instructores, jsonData, puertos;
            cursoProgramado.rollback();
            ($("#movimientoConfirmDialog")).modal('hide');
            jsonData = eval('(' + reason.responseText + ')');
            cursos = "" + jsonData.curso + ",";
            puertos = "" + jsonData.puerto + ",";
            instructores = "" + jsonData.instructor + ",";
            desde = moment(jsonData.fechaDeInicio, "YYYY-MM-DD").format('DD/MM/YYYY');
            hasta = moment(jsonData.fechaDeTermino, "YYYY-MM-DD").format('DD/MM/YYYY');
            ($("#duplicacion > .modal-body")).html("<p> Se ha encontrado un curso con los mismos datos : </p>\n\n<dl class=\"dl-horizontal\">\n  <dt>Fecha de inicio</dt>\n  <dd>" + desde + "</dd>\n\n  <dt>Fecha de término</dt>\n  <dd>" + hasta + "</dd>\n\n  <dt>Instructor</dt>\n  <dd>" + (instructores.replace(',', '')) + "</dd>\n\n  <dt>Curso</dt>\n  <dd>" + (cursos.replace(',', '')) + "</dd>\n\n  <dt>Puerto</dt>\n  <dd>" + (puertos.replace(',', '')) + "</dd>\n</dl>");
            ($("#duplicacion > .modal-footer")).html("<a href=\"/busqueda/realizarBusqueda?buscar=&cursos=" + cursos + "&puertos=" + puertos + "&instructores=" + instructores + "&desde=" + desde + "&hasta=" + hasta + "&offset=0&max=10\" id=\"busqueda\" class=\"btn btn-primary\"> Ver los datos duplicados </a>");
            _this.busquedaGetWithSelector("#busqueda");
            $("body").on("click", "#busqueda", function(event) {
              $("#duplicacion").modal('hide');
              return _this.transitionToRoute('busqueda');
            });
            return ($("#duplicacion")).modal('show');
          };
        })(this));
        return ($("#primary")).attr('disabled', false);
      }
    }
  });

});
