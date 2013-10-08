Ember.Handlebars.registerBoundHelper 'date', (date) ->
  moment(date).format('DD/MMMM/YYYY')