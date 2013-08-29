DS.RESTAdapter.configure "plurals",
  instructor: "instructores"

DS.RESTAdapter.map 'App.CursoProgramado',
  fechaDeInicio: { key: 'fechaDeInicio' }
  fechaDeTermino: { key: 'fechaDeTermino' }
  dateCreated: { key: 'dateCreated' }

  puerto : { key: 'puerto' }
  curso : { key : 'curso' }
  instructor : { key : 'instructor' }

  statusCurso: { key: 'statusCurso' }

  alumnos : { embedded: 'always' }

  keyForAttributeName: (type, name) ->
    console.log "keyForAttributeName"
    return name.underscore.toUpperCase()

App.Store = DS.Store.extend
  revision: 13,
  adapter: DS.RESTAdapter.reopen
    namespace: "siyen"
    serializer: DS.RESTSerializer.create
      keyForBelongsTo: (type, name) ->
        console.log "keyForBelongsTo"
        return @.keyForAttributeName(type, name) + "Id"

      keyForAttributeName: (type, name) ->
        return name

      keyForHasMany : (type, name) ->
        console.log "keyForHasMany"
        console.log "#{name}"
        return @.keyForAttributeName(type, name)

