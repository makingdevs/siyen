inflector = Ember.Inflector.inflector
inflector.irregular('cursoprogramado', 'cursos_programados')
inflector.irregular('instructor', 'instructores')

App.Store = DS.Store.extend
  adapter: DS.RESTAdapter.extend
    namespace: 'siyen'

    createRecord : (store, type, record) ->
      serializer = store.serializerFor(type.typeKey)
      data = serializer.serializeIntoHash(data, type, record, { includeId: true })
      console.log data
      @.ajax(@.buildURL(type.typeKey), "POST", { data : data })

App.ApplicationSerializer = DS.RESTSerializer.extend
  serializeIntoHash: (data, type, record, options) ->
    console.log "record"
    console.log record
    @serialize(record, options)