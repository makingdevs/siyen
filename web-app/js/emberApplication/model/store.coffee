DS.RESTAdapter.configure "plurals",
  instructor: "instructores"
  cursoProgramado : "cursosProgramados"
  curso_programado : "cursos_programados"

DS.RESTAdapter.map 'App.CursoProgramado',
  fechaDeInicio: { key: 'fechaDeInicio' }
  fechaDeTermino: { key: 'fechaDeTermino' }
  dateCreated: { key: 'dateCreated' }

  puerto : { key: 'puerto' }
  curso : { key : 'curso' }
  instructor : { key : 'instructor' }

  statusCurso: { key: 'statusCurso' }

  alumnos : { embedded: 'always' }

App.Store = DS.Store.extend
  revision: 13,
  adapter: DS.RESTAdapter.extend
    namespace: "siyen"

    createRecord : (store, type, record) ->
      root = @rootForType(type)
      adapter = @
      data = {}
      data = @serialize( record, includeId: true )

      @ajax(@buildURL(root), "POST", data: data ).then((json) ->
        adapter.didCreateRecord( store, type, record, json )
      , (xhr) ->
        adapter.didError store, type, record, xhr
        throw xhr
      ).then( null, DS.rejectionHandler )