inflector = Ember.Inflector.inflector
inflector.irregular('cursoprogramado', 'cursos_programados')
inflector.irregular('cursoProgramado', 'cursos_programados')
inflector.irregular('instructor', 'instructores')

App.Store = DS.Store.extend
  adapter: DS.RESTAdapter.extend
    namespace: 'siyen'

    createRecord : (store, type, record) ->
      serializer = store.serializerFor(type.typeKey)
      data = serializer.serializeIntoHash(data, type, record, { includeId: true })
      @ajax( @buildURL(type.typeKey), "POST", { data : data } )

App.ApplicationSerializer = DS.RESTSerializer.extend
  serializeIntoHash: (data, type, record, options) ->
    @serialize(record, options)