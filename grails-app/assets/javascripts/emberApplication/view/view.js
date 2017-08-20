//=require dropzone/dropzone.min.js
$(function() {
  var DragNDrop;

  App.CursosNuevosView = Ember.View.extend({
    elementId: "cursosNuevos"
  });

  App.DatePickerView = Ember.View.extend({
    fechaValue: null,
    initValue: true,
    template: Ember.Handlebars.compile('<div class="input-append date" >' + '{{ view Ember.TextField valueBinding="view.fechaValue" class="datepicker" }}' + '<span class="add-on"><i class="icon-th"></i></span>' + '</div>'),
    didInsertElement: function() {
      ($('.datepicker')).datepicker({
        format: "dd/MM/yyyy",
        autoclose: true,
        todayHighlight: true,
        language: 'es',
        startDate: this.get('initValue') === true ? '-15d' : void 0,
        clearBtn: !this.get('initValue')
      });
      ($(".datepicker")).attr('readonly', 'true');
      if (this.get('initValue')) {
        return ($(".datepicker")).val(moment().format('DD/MMMM/YYYY'));
      }
    }
  });

  App.DropzoneView = Ember.View.extend({
    template: Ember.Handlebars.compile('<div id="dropzone" class="dropzone"> </div>'),
    didInsertElement: function() {
      var dropzone;
      Dropzone.autoDiscover = false;
      $('div#dropzone').dropzone({
        url: "procesarArchivo",
        addRemoveLinks: true,
        maxFiles: 1,
        maxFilesize: 3,
        autoProcessQueue: false
      });
      dropzone = Dropzone.forElement("div#dropzone.dropzone");
      return dropzone.on("success", (function(_this) {
        return function(file, response) {
          var fila, participantes, _i, _len, _ref, _results;
          file.previewElement.classList.add("dz-success");
          _ref = response.contenidoDeFilas;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            fila = _ref[_i];
            participantes = _this.get("controller.participantes");
            _results.push(participantes.pushObject(Ember.Object.create({
              nombreCompleto: fila.get(0),
              observaciones: $.trim(fila.get(1)),
              monto: fila.get(2),
              tipoDePago: fila.get(3)
            })));
          }
          return _results;
        };
      })(this));
    }
  });

  App.CursoNuevoListView = Ember.View.extend({
    elementId: 'cursoNuevoList',
    tagName: '',
    template: Ember.Handlebars.compile('' + '{{#each controller}}' + '{{ view App.CursoNuevoItemView contentBinding="this" }}' + '{{/each}}')
  });

  App.CursoNuevoItemView = Ember.View.extend({
    tagName: 'tr',
    template: Ember.Handlebars.compile('' + '<td> {{ date fechaDeInicio }} </td>' + '<td> {{ puerto.clave }} - {{ puerto.puerto }} </td>' + '<td> {{ curso.clave }} </td>' + '<td> {{ instructor.nombre }} </td>' + '<td> {{ alumnos.length }}' + '<td> {{ view App.AutorizarView }} </td>'),
    click: function() {
      return this.get('controller').set('currentCurso', this.get('content'));
    }
  });

  App.AutorizarView = Ember.View.extend({
    tagName: 'button',
    classNames: ['btn', 'btn-warning'],
    attributeBindings: ['disabled'],
    disabled: (function() {
      if (!this.get('context.alumnos.length')) {
        return "disabled";
      }
    }).property("context.alumnos.length"),
    template: Ember.Handlebars.compile('Autorizar'),
    click: function(event) {
      event.stopPropagation();
      this.get('controller').set('autorizarCurso', this.get('context'));
      return this.get('controller').autorizar();
    }
  });

  App.EditarParticipantesListView = Ember.View.extend({
    elementId: 'participantes',
    tagName: 'table',
    classNames: ["table", "table-condensed", "table-striped", "table-hover"],
    template: Ember.Handlebars.compile("<thead>\n  <tr>\n  <th># Control</th>\n    <th>Nombre</th>\n    <th>Tipo de pago</th>\n    <th>Observaciones</th>\n    <th>Monto</th>\n    <th>Encuesta</th>\n    <th>Certificado</th>\n  </tr>\n</thead>\n<tbody>\n  {{#each model.alumnos}}\n    {{ view App.ParticipanteView contentBinding=\"this\" classNameBindings=this.infoLabel }}\n  {{/each}}\n</tbody>")
  });

  App.ParticipantesListView = Ember.View.extend({
    elementId: 'participantes',
    tagName: 'table',
    classNames: ["table", "table-condensed", "table-striped", "table-hover"],
    template: Ember.Handlebars.compile("<thead>\n  <tr>\n    <th>Nombre</th>\n    <th>Tipo de pago</th>\n    <th>Observaciones</th>\n    <th>Monto</th>\n    <th>&nbsp;</th>\n  </tr>\n</thead>\n<tbody>\n  {{#each controllers.cursosNuevos.currentCurso.alumnos}}\n    {{ view App.ParticipanteView contentBinding=\"this\" classNameBindings=this.isNew }}\n  {{/each}}\n</tbody>")
  });

  App.ParticipanteView = Ember.View.extend({
    tagName: 'tr',
    template: Ember.Handlebars.compile('' + "{{#if numeroDeControl}}<td> {{ numeroDeControl }} </td>\n{{/if}}<td> {{ nombreCompleto }} </td>\n<td> {{ tipoDePago }} </td>\n<td> {{ observaciones }} </td>\n<td> <span class=\"badge badge-info\">${{ monto }}</span> </td>\n<td> {{#if id}} {{ view App.EncuestaButton class=\"btn btn-primary\" }} {{/if}} </td>\n<td> {{#if id}} {{ view App.CertificadoPorParticipanteButton class=\"btn btn-success\"}} {{/if}} </td>"),
    click: function(event) {
      var controller, tipoDePagoSelected;
      controller = this.get('controller');
      controller.set('nombreCompleto', this.get('context.nombreCompleto'));
      controller.set('observaciones', this.get('context.observaciones'));
      tipoDePagoSelected = controller.get('tiposDePagos').findBy('id', this.get('context.tipoDePago'));
      controller.set('tipoDePagoSelected', tipoDePagoSelected);
      controller.set('monto', this.get('context.monto'));
      controller.set('currentParticipanteIndex', this.get('_parentView.contentIndex'));
      return ($('#nombreCompleto')).focus();
    }
  });

  App.TextField = Ember.TextField.extend(Ember.TargetActionSupport, {
    insertNewline: function() {
      return this.triggerAction();
    }
  });

  App.BootstrapButton = Ember.View.extend(Ember.TargetActionSupport, {
    tagName: 'button',
    classNames: ['btn'],
    iconName: null,
    disabled: false,
    click: function() {
      if (!this.get('disabled')) {
        return this.triggerAction();
      }
    },
    template: Ember.Handlebars.compile('{{#if view.iconName}}<i {{bindAttr class="view.iconName"}}></i>{{/if}} {{view.content}}')
  });

  App.EncuestaButton = Ember.View.extend(Ember.TargetActionSupport, {
    tagName: 'a',
    classNames: ['btn btn-primary'],
    iconName: "icon-check icon-white",
    click: function() {
      var id, urlSurvey, urlSurveyBase;
      id = this.get('context.id');
      urlSurveyBase = ($("#surveyable")).val();
      urlSurvey = "" + urlSurveyBase + "/" + id;
      return window.location.href = urlSurvey;
    },
    template: Ember.Handlebars.compile('<i {{bindAttr class="view.iconName"}}></i>')
  });

  App.CertificadoButton = Ember.View.extend(Ember.TargetActionSupport, {
    tagName: 'a',
    classNames: ['btn btn-success'],
    iconName: "icon-print icon-white",
    click: function() {
      var id, urlBaseFrente, urlBaseReverso, urlFrente, urlReverso;
      id = this.get('context.id');
      urlBaseFrente = ($('#frenteParaCurso')).val();
      urlFrente = "" + urlBaseFrente + "/" + id;
      urlBaseReverso = ($('#reversoParaCurso')).val();
      urlReverso = "" + urlBaseReverso + "/" + id;
      window.open(urlFrente);
      return window.open(urlReverso);
    },
    template: Ember.Handlebars.compile('<i {{bindAttr class="view.iconName"}}></i>')
  });

  App.CertificadoPorParticipanteButton = Ember.View.extend(Ember.TargetActionSupport, {
    tagName: 'a',
    iconName: "icon-print icon-white",
    click: function() {
      var id, urlBaseFrente, urlBaseReverso, urlFrente, urlReverso;
      id = this.get('context.id');
      urlBaseFrente = ($('#frenteParaCursoPorAlumno')).val();
      urlFrente = "" + urlBaseFrente + "/" + id;
      urlBaseReverso = ($('#reversoParaCursoPorAlumno')).val();
      urlReverso = "" + urlBaseReverso + "/" + id;
      window.open(urlFrente);
      window.open(urlReverso);
      return false;
    },
    template: Ember.Handlebars.compile('<i {{bindAttr class="view.iconName"}}></i>')
  });

  App.OficioButton = Ember.View.extend(Ember.TargetActionSupport, {
    tagName: 'a',
    classNames: ['btn btn-primary'],
    click: function() {
      var deParteDe, desde, dirigidoA, hasta, puerto, puesto, urlGenerarOficios;
      urlGenerarOficios = ($('#generarOficios')).val();
      dirigidoA = this.get('context.dirigidoA');
      puesto = this.get('context.puesto');
      deParteDe = this.get('context.deParteDe.id');
      puerto = this.get('context.puerto.id');
      desde = this.get('context.desde');
      hasta = this.get('context.hasta');
      window.open("" + urlGenerarOficios + "?dirigidoA=" + dirigidoA + "&puesto=" + puesto + "&deParteDe=" + deParteDe + "&puertoDeEnvio=" + puerto + "&desde=" + desde + "&hasta=" + hasta);
      return false;
    },
    template: Ember.Handlebars.compile('Generar')
  });

  App.CursosAutorizadosView = Ember.View.extend();

  App.ConfirmDialogView = Ember.View.extend({
    templateName: 'confirmDialog',
    classNames: ['modal', 'hide'],
    cancelButtonLabel: 'Cancel',
    cancelAction: null,
    okButtonLabel: "Confirmar",
    okAction: null,
    header: null,
    message: null,
    target: null
  });

  App.CursoNuevoFormulario = Ember.View.extend({
    templateName: 'cursoNuevoForm',
    finalizarButtonLabel: "Finalizar",
    finalizarAction: "finalizar",
    crearAgregarButtonLabel: "Crear y agregar participantes",
    crearAgregarAction: null,
    header: null,
    target: null
  });

  App.NotifacionView = Ember.View.extend();

  App.BusquedaView = Ember.View.extend({
    didInsertElement: function() {
      var tamanioCampoBusqueda;
      tamanioCampoBusqueda = $("input[name='busqueda']").width();
      $("#busquedaAvanzada").width(tamanioCampoBusqueda);
      return $("#mostrarBusquedaAvanzada").click(function() {
        $("#busquedaAvanzada").toggle("slow");
        return $(".busquedaChosen").chosen({
          disable_search: true,
          search_contains: true,
          display_selected_options: false,
          placeholder_text_multiple: "Selecciona algunas opciones",
          no_results_text: "Oops, ¡No hubo resultados!"
        });
      });
    }
  });

  App.BootstrapButton = Ember.View.extend(Ember.TargetActionSupport, {
    tagName: 'button',
    classNames: ['btn'],
    iconName: null,
    disabled: false,
    click: function() {
      if (!this.get('disabled')) {
        return this.triggerAction();
      }
    },
    template: Ember.Handlebars.compile('{{#if view.iconName}}<i {{bindAttr class="view.iconName"}}></i>{{/if}} {{view.content}}')
  });

  App.BusquedaAvanzadaView = Ember.View.extend({
    classNames: "hide",
    template: Ember.Handlebars.compile('' + '<div class="control-group">' + '<label class="control-label" for="cursos">Cursos :</label>' + '<div class="controls">' + '<select id="cursos" class="busquedaChosen input-xxlarge" multiple> </select>' + '</div>' + '</div>' + '<div class="control-group">' + '<label class="control-label" for="puertos">Puertos :</label>' + '<div class="controls">' + '<select id="puertos" class="busquedaChosen input-xxlarge" multiple> </select>' + '</div>' + '</div>' + '<div class="control-group">' + '<label class="control-label" for="instructores">Instructores :</label>' + '<div class="controls">' + '<select id="instructores" class="busquedaChosen input-xxlarge" multiple> </select>' + '</div>' + '</div>' + '<div class="control-group">' + '<label class="control-label" for="instructores">Desde :</label>' + '<div class="controls">' + '{{ view App.DatePickerView fechaValueBinding="desde" initValue=false }}' + '</div>' + '</div>' + '<div class="control-group">' + '<label class="control-label" for="instructores">Hasta :</label>' + '<div class="controls">' + '{{ view App.DatePickerView fechaValueBinding="hasta" initValue=false }}' + '</div>' + '</div>')
  });

  DragNDrop = Ember.Namespace.create();

  DragNDrop.cancel = function(event) {
    event.preventDefault();
    return false;
  };

  DragNDrop.Dragable = Ember.Mixin.create({
    attributeBindings: ['draggable', 'style'],
    draggable: 'true',
    style: 'cursor:move;',
    dragStart: function(event) {
      var dataTransfer;
      this.set('style', 'cursor:move;opacity:0.4');
      $(".well").css({
        "opacity": '0.4',
        "background-image": "url('/images/arrastra_aqui.png')",
        "background-repeat": "no-repeat",
        "background-position": "center"
      });
      dataTransfer = event.originalEvent.dataTransfer;
      dataTransfer.setData('Text', this.get('elementId'));
      return this.set('_context.isDragging', true);
    },
    dragEnd: function(event) {
      this.set('style', 'cursor:move;opacity:1.0');
      return $(".well").css({
        "opacity": '1.0',
        "background-image": ""
      });
    }
  });

  DragNDrop.Droppable = Ember.Mixin.create({
    dragEnter: DragNDrop.cancel,
    dragOver: DragNDrop.cancel,
    attributeBindings: "dropTarget",
    dropTarget: false,
    drop: function(event) {
      event.preventDefault();
      return false;
    }
  });

  App.ListaAlumnosView = Ember.View.extend(DragNDrop.Droppable, {
    tagName: 'ul',
    classNames: "well",
    drop: function(event) {
      var cursoProgramadoTarget, dropTargetId, view, viewId;
      viewId = event.originalEvent.dataTransfer.getData('Text');
      view = Ember.View.views[viewId];
      dropTargetId = event.currentTarget.id;
      if (view.get('parentView.elementId') !== dropTargetId) {
        ($("#confirmarMovimientoDialog")).modal({
          show: true
        });
        cursoProgramadoTarget = Ember.View.views[dropTargetId];
        view.set('_context.droppingTarget', cursoProgramadoTarget.get('content'));
      }
      return this._super(event);
    },
    template: Ember.Handlebars.compile("{{#if view.content}}\n  <dl class=\"dl-horizontal\">\n    <dt>Fecha de inicio</dt>\n    <dd>{{ date view.content.fechaDeInicio }}</dd>\n\n    <dt>Instructor</dt>\n    <dd>{{ view.content.instructor.nombre }}</dd>\n\n    <dt>Curso</dt>\n    <dd>{{ view.content.curso.clave }}</dd>\n\n    <dt>Puerto</dt>\n    <dd>{{ view.content.puerto.descripcion }}</dd>\n  </dl>\n{{/if}}\n\n{{#each view.content.alumnos}}\n  <li> {{ view App.AlumnoDnDView }} {{ descripcion }} {{ view App.CertificadoPorParticipanteButton class='btn-link' iconName=\"icon-print\" }} </li>\n{{/each}}")
  });

  App.AlumnoDnDView = Ember.View.extend(DragNDrop.Dragable, {
    tagName: 'i',
    classNames: "icon-move",
    dragStart: function(event) {
      var dataTransfer;
      this._super(event);
      return dataTransfer = event.originalEvent.dataTransfer;
    }
  });

});