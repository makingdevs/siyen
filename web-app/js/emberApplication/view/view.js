// Generated by CoffeeScript 1.6.3
(function() {
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
        startDate: this.get('initValue') === true ? '1d' : void 0,
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
      return $('div#dropzone').dropzone({
        url: "procesarArchivo",
        addRemoveLinks: true,
        maxFiles: 1,
        maxFilesize: 3,
        autoProcessQueue: false
      });
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
    template: Ember.Handlebars.compile("<thead>\n  <tr>\n    <th>Nombre</th>\n    <th>Observaciones</th>\n    <th>Monto</th>\n    <th>&nbsp;</th>\n  </tr>\n</thead>\n<tbody>\n  {{#each model.alumnos}}\n    {{ view App.ParticipanteView contentBinding=\"this\" }}\n  {{/each}}\n</tbody>")
  });

  App.ParticipantesListView = Ember.View.extend({
    elementId: 'participantes',
    tagName: 'table',
    classNames: ["table", "table-condensed", "table-striped", "table-hover"],
    template: Ember.Handlebars.compile("<thead>\n  <tr>\n    <th>Nombre</th>\n    <th>Observaciones</th>\n    <th>Monto</th>\n    <th>&nbsp;</th>\n  </tr>\n</thead>\n<tbody>\n  {{#each controllers.cursosNuevos.currentCurso.alumnos}}\n    {{ view App.ParticipanteView contentBinding=\"this\" }}\n  {{/each}}\n</tbody>")
  });

  App.ParticipanteView = Ember.View.extend({
    tagName: 'tr',
    template: Ember.Handlebars.compile('' + "<td> {{ nombreCompleto }} </td>\n<td> {{#if observaciones}} - <small>{{ observaciones }}</small>{{/if}} </td>\n<td> {{#if monto}} - <span class=\"badge badge-info\">${{ monto }}</span>{{/if}} </td>\n<td> {{#if id}} {{ view App.CertificadoPorParticipanteButton }} {{/if}} </td>"),
    click: function(event) {
      var controller;
      controller = this.get('controller');
      controller.set('nombreCompleto', this.get('context.nombreCompleto'));
      controller.set('observaciones', this.get('context.observaciones'));
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
    classNames: ['btn btn-success'],
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
      dataTransfer = event.originalEvent.dataTransfer;
      return dataTransfer.setData('Text', this.get('elementId'));
    },
    dragEnd: function(event) {
      return this.set('style', 'cursor:move;opacity:1.0');
    }
  });

  DragNDrop.Droppable = Ember.Mixin.create({
    dragEnter: DragNDrop.cancel,
    dragOver: DragNDrop.cancel,
    drop: function(event) {
      event.preventDefault();
      return false;
    }
  });

  App.ListaAlumnosView = Ember.View.extend(DragNDrop.Droppable, {
    tagName: 'ul',
    drop: function(event) {
      var alumno, cursoProgramadoTarget, dropTargetId, view, viewId;
      viewId = event.originalEvent.dataTransfer.getData('Text');
      view = Ember.View.views[viewId];
      dropTargetId = event.currentTarget.id;
      if (view.get('parentView.elementId') !== dropTargetId) {
        cursoProgramadoTarget = Ember.View.views[dropTargetId];
        alumno = view.get('_context');
        alumno.set('cursoProgramado', cursoProgramadoTarget.get('content'));
        alumno.save();
      }
      return this._super(event);
    },
    template: Ember.Handlebars.compile("{{#each view.content.alumnos}}\n  {{ view App.AlumnoDnDView }}\n{{/each}}")
  });

  App.AlumnoDnDView = Ember.View.extend(DragNDrop.Dragable, {
    tagName: 'li',
    dragStart: function(event) {
      var dataTransfer;
      this._super(event);
      return dataTransfer = event.originalEvent.dataTransfer;
    },
    template: Ember.Handlebars.compile("<i class='icon-move'></i> {{ descripcion }}")
  });

}).call(this);
