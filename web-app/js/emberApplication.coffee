window.App = Ember.Application.create()

$ ->
  ($ "body").on "click", "#impresion", ->
    id = ($ this).attr('name')
    urlbasefrente = ($ '#frenteparacurso').val()
    urlfrente = "#{urlbasefrente}/#{id}"

    urlbasereverso = ($ '#reversoparacurso').val()
    urlreverso = "#{urlbasereverso}/#{id}"

    window.open(urlfrente)
    window.open(urlreverso)

  ($ "body").on "click", "#impresionDeAlumno", ->
    id = ($ this).attr('name')

    urlBaseFrente = ($ '#frenteParaCursoPorAlumno').val()
    urlFrente = "#{urlBaseFrente}/#{id}"

    urlBaseReverso = ($ '#reversoParaCursoPorAlumno').val()
    urlReverso = "#{urlBaseReverso}/#{id}"

    window.open(urlFrente)
    window.open(urlReverso)
    return false
