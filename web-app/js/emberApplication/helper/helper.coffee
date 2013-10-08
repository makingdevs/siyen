Ember.Handlebars.registerBoundHelper 'date', (date) ->
  moment(date).format('DD/MMMM/YYYY')

Ember.Handlebars.registerBoundHelper 'certificado', (id) ->
  url = ($ '#certificadosURL').val()
  window.open("http://www.google.com")
  link = "<button class='btn btn-success'><i class='icon-print icon-white'></i></button>"
  # #{url}/#{id}
  new Handlebars.SafeString(link)