Ember.Handlebars.registerBoundHelper 'date', (date) ->
  moment(date).format('DD/MMMM/YYYY')

Ember.Handlebars.registerBoundHelper 'certificado', (id) ->
  url = ($ '#certificadosURL').val()
  link = "<a href='#{url}/#{id}' class='btn btn-success'><i class='icon-print icon-white'></i> </a>"
  new Handlebars.SafeString(link)