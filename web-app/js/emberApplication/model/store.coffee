inflector = Ember.Inflector.inflector
inflector.irregular('cursoprogramado', 'cursos_programados')
inflector.irregular('cursoProgramado', 'cursos_programados')
inflector.irregular('instructor', 'instructores')

App.Store = DS.Store.extend
  adapter: DS.RESTAdapter.extend
    createRecord : (store, type, record) ->
      serializer = store.serializerFor(type.typeKey)
      data = serializer.serializeIntoHash(data, type, record, { includeId: true })
      @ajax( @buildURL(type.typeKey), "POST", { data : data } )

    updateRecord: (store, type, record) ->
      serializer = store.serializerFor(type.typeKey)
      data = serializer.serializeIntoHash(data, type, record)
      id = record.get('id')
      @ajax(@buildURL(type.typeKey, id), "PUT", { data: data })

App.ApplicationSerializer = DS.RESTSerializer.extend
  serializeIntoHash: (data, type, record, options) ->
    @serialize(record, options)