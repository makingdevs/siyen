// Generated by CoffeeScript 1.7.1
(function() {
  var inflector;

  inflector = Ember.Inflector.inflector;

  inflector.irregular('cursoprogramado', 'cursos_programados');

  inflector.irregular('cursoProgramado', 'cursos_programados');

  inflector.irregular('instructor', 'instructores');

  App.Store = DS.Store.extend({
    adapter: DS.RESTAdapter.extend({
      createRecord: function(store, type, record) {
        var data, serializer;
        serializer = store.serializerFor(type.typeKey);
        data = serializer.serializeIntoHash(data, type, record, {
          includeId: true
        });
        return this.ajax(this.buildURL(type.typeKey), "POST", {
          data: data
        });
      },
      updateRecord: function(store, type, record) {
        var data, id, serializer;
        serializer = store.serializerFor(type.typeKey);
        data = serializer.serializeIntoHash(data, type, record);
        id = record.get('id');
        return this.ajax(this.buildURL(type.typeKey, id), "PUT", {
          data: data
        });
      }
    })
  });

  App.ApplicationSerializer = DS.RESTSerializer.extend({
    serializeIntoHash: function(data, type, record, options) {
      return this.serialize(record, options);
    }
  });

  App.NotificacionSerializer = DS.LSSerializer.extend();

  App.NotificacionAdapter = DS.LSAdapter.extend({
    namespace: 'notificaciones'
  });

}).call(this);
