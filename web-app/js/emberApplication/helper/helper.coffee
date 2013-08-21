Ember.Handlebars.registerBoundHelper 'date', (date) ->
  moment(date).format('DD/MMMM/YYYY')

Ember.Handlebars.registerBoundHelper 'showButton', (length) ->
  button = "<button class='btn btn-warning #{'disabled' unless length}'> Autorizar </button>"
  new Handlebars.SafeString( button )