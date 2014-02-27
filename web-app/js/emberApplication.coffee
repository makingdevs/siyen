window.App = Ember.Application.create()

$ ->
  $(document).ajaxStart ->
    ($ '.overlay').show()

  $(document).ajaxStop ->
    ($ '.overlay').hide()

  ($ "body").on "click", "#impresion", ->
    id = ($ this).attr('name')
    urlBaseFrente = ($ '#frenteParaCurso').val()
    urlFrente = "#{urlBaseFrente}/#{id}"

    urlBaseReverso = ($ '#reversoParaCurso').val()
    urlReverso = "#{urlBaseReverso}/#{id}"

    window.open(urlFrente)
    window.open(urlReverso)

  ($ "body").on "click", "#impresionDeAlumno", ->
    id = ($ this).attr('name')

    urlBaseFrente = ($ '#frenteParaCursoPorAlumno').val()
    urlFrente = "#{urlBaseFrente}/#{id}"

    urlBaseReverso = ($ '#reversoParaCursoPorAlumno').val()
    urlReverso = "#{urlBaseReverso}/#{id}"

    window.open(urlFrente)
    window.open(urlReverso)
    return false
