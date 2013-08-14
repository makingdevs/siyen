// Generated by CoffeeScript 1.6.3
(function() {
  window.App = Ember.Application.create();

  App.Router.map(function() {
    return this.resource('cursosProgramados', function() {
      return this.route('nuevo');
    });
  });

  App.CursosProgramadosRoute = Ember.Route.extend({
    model: function() {
      return App.CursoProgramado.find();
    }
  });

  App.CursosProgramadosNuevoController = Ember.ObjectController.extend({
    instructores: [],
    puertos: [],
    cursos: [],
    puertoSelected: null,
    instructorSelected: null,
    cursoSelected: null,
    fechaDeInicio: null,
    guardar: function() {
      var dateCreated, fechaDeInicio, fechaDeTermino, _ref;
      console.log("guardando");
      fechaDeInicio = (_ref = this.fechaDeInicio) != null ? _ref : moment();
      fechaDeTermino = moment(fechaDeInicio).add('days', 4);
      dateCreated = fechaDeInicio;
      return App.CursoProgramado.createRecord({
        fechaDeInicio: fechaDeInicio,
        fechaDeTermino: fechaDeTermino,
        dateCreated: dateCreated,
        puerto: this.puertoSelected,
        curso: this.instructorSelected,
        instructor: this.cursoSelected,
        statusCurso: "NUEVO"
      });
    }
  });

  App.CursosProgramadosNuevoRoute = Ember.Route.extend({
    setupController: function(controller, model) {
      controller.set('instructores', App.Instructor.find());
      controller.set('puertos', App.Puerto.find());
      return controller.set('cursos', App.Curso.find());
    }
  });

  App.Store = DS.Store.extend({
    revision: 13,
    adapter: DS.RESTAdapter.reopen({
      namespace: "siyen"
    })
  });

  App.CursoProgramado = DS.Model.extend({
    fechaDeInicio: DS.attr('date'),
    fechaDeTermino: DS.attr('date'),
    dateCreated: DS.attr('date'),
    puerto: DS.belongsTo('App.Puerto'),
    curso: DS.belongsTo('App.Curso'),
    instructor: DS.belongsTo('App.Instructor'),
    statusCurso: DS.attr('string')
  });

  App.Puerto = DS.Model.extend({
    clave: DS.attr('string'),
    puerto: DS.attr('string')
  });

  App.Curso = DS.Model.extend({
    clave: DS.attr('string'),
    nombre: DS.attr('string')
  });

  App.Instructor = DS.Model.extend({
    nombre: DS.attr('string'),
    numeroDeOficio: DS.attr('string')
  });

  App.StatusCurso = DS.Model.extend({
    name: DS.attr('string')
  });

  DS.RESTAdapter.map('App.CursoProgramado', {
    fechaDeInicio: {
      key: 'fechaDeInicio'
    },
    fechaDeTermino: {
      key: 'fechaDeTermino'
    },
    dateCreated: {
      key: 'dateCreated'
    },
    puerto: {
      key: 'puerto'
    },
    curso: {
      key: 'curso'
    },
    instructor: {
      key: 'instructor'
    },
    statusCurso: {
      key: 'statusCurso'
    }
  });

  Ember.Handlebars.registerBoundHelper('date', function(date) {
    return moment(date).format('DD/MMMM/YYYY');
  });

  App.DatePickerView = Ember.View.extend({
    template: Ember.Handlebars.compile('<div class="input-append date" id="datepicker" >' + '<input size="16" type="text" readonly>' + '<span class="add-on"><i class="icon-th"></i></span>' + '</div>'),
    didInsertElement: function() {
      var onChangeDate,
        _this = this;
      onChangeDate = function(ev) {
        return _this.set("value", moment.utc(ev.date).format("DD/MM/YYYY"));
      };
      ($('#datepicker')).datepicker({
        format: "dd/MM/yyyy",
        autoclose: true,
        todayHighlight: true,
        language: 'es',
        startDate: '1d'
      }).on("changeDate", onChangeDate);
      return ($("#datepicker > input")).val(moment().format('DD/MMMM/YYYY'));
    }
  });

}).call(this);
