window.App = Ember.Application.create()

$ ->
  ($ "body").on "click", "#impresion", ->
    id = ($ this).attr('name')
    urlBaseFrente = ($ '#frenteParaCurso').val()
    urlFrente = "#{urlBaseFrente}/#{id}"

    urlBaseReverso = ($ '#reversoParaCurso').val()
    urlReverso = "#{urlBaseReverso}/#{id}"

    window.open(urlFrente)
    window.open(urlReverso)
