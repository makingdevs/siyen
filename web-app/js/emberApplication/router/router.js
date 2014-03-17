// Generated by CoffeeScript 1.7.1
(function() {
  App.Router.map(function() {
    this.route('archivo');
    this.route('notificacion');
    this.route('busqueda');
    this.route('busquedaAlumnos');
    this.route('oficios');
    this.route('movimientos');
    this.resource('cursosNuevos', function() {
      return this.resource('crear', function() {
        return this.route('participantes');
      });
    });
    this.resource('alumnos', function() {
      return this.resource('alumno', {
        path: ":alumno_id"
      });
    });
    return this.resource('cursosAutorizados', function() {
      return this.resource('edit', {
        path: ":curso_programado_id"
      });
    });
  });

  App.CursosNuevosRoute = Ember.Route.extend();

  App.CursosNuevosCrearRoute = Ember.Route.extend();

  App.CrearParticipantesRoute = Ember.Route.extend();

  App.ArchivoRoute = Ember.Route.extend();

  App.NotificacionRoute = Ember.Route.extend({
    model: function() {
      return this.get('store').find('notificacion');
    }
  });

  App.CursosAutorizadosRoute = Ember.Route.extend({
    model: function() {
      return this.get('store').find('cursoProgramado');
    }
  });

  App.EditRoute = Ember.Route.extend({
    setupController: function(controller, model) {
      var fechaDeInicio, fechaDeInicioModel;
      fechaDeInicioModel = model.get('fechaDeInicio');
      fechaDeInicio = moment(fechaDeInicioModel).format('DD/MMMM/YYYY');
      controller.set('fechaDeInicio', fechaDeInicio);
      controller.set('model', model);
      controller.set('disabled', false);
      if (moment().diff(moment(fechaDeInicio, 'DD/MMMM/YYYY'), 'days') > 15 || model.get('alumnosRestantes') <= 0) {
        return controller.set('disabled', true);
      }
    },
    model: function(params) {
      return this.get('store').find('cursoProgramado', params.curso_programado_id);
    }
  });

  App.BusquedaRoute = Ember.Route.extend({
    setupController: function(controller, model) {
      this._super(controller, model);
      return $.getJSON("catalogo/obtenerDatosDeBusqueda", function(data) {
        var cursos, instructores, puertos, value, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
        cursos = $("#cursos");
        _ref = data.cursos;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          value = _ref[_i];
          $("<option value='" + value + "'>" + value + "</option>").appendTo(cursos);
        }
        puertos = $("#puertos");
        _ref1 = data.puertos;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          value = _ref1[_j];
          $("<option value='" + value + "'>" + value + "</option>").appendTo(puertos);
        }
        instructores = $("#instructores");
        _ref2 = data.instructores;
        for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
          value = _ref2[_k];
          $("<option value='" + value.nombre + "'>" + value.nombre + "</option>").appendTo(instructores);
        }
        return $(".busquedaChosen").trigger("chosen:updated");
      });
    }
  });

  App.MovimientosRoute = Ember.Route.extend({
    model: function() {
      return this.get('store').find('cursoProgramado');
    }
  });

  App.OficiosRoute = Ember.Route.extend({
    setupController: function(controller, model) {
      this._super(controller, model);
      controller.set('instructores', this.get('store').find('instructor'));
      return controller.set('puertos', this.get('store').find('puerto'));
    }
  });

}).call(this);
